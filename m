Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA530C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93E620723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgFFB66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 21:58:58 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:36404 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728542AbgFFB64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 21:58:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E4125100E7B40;
        Sat,  6 Jun 2020 01:58:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger26_561811d26da4
X-Filterd-Recvd-Size: 5940
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Jun 2020 01:58:54 +0000 (UTC)
Message-ID: <88789e3a4ee6134246e83ae3b8d8d4664784e3fd.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add test for possible misuse of
 IS_ENABLED() without CONFIG_
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Date:   Fri, 05 Jun 2020 18:58:52 -0700
In-Reply-To: <20200605173228.3c37b0f40b91c7291c52f750@linux-foundation.org>
References: <202006050718.9D4FCFC2E@keescook>
         <e7fda760b91b769ba82844ba282d432c0d26d709.camel@perches.com>
         <20200605173228.3c37b0f40b91c7291c52f750@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-05 at 17:32 -0700, Andrew Morton wrote:
> On Fri, 05 Jun 2020 11:24:43 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > IS_ENABLED is almost always used with CONFIG_<FOO> defines.
> > 
> > Add a test to verify that the #define being tested starts with CONFIG_.
> 
> Yay.
> 
> I wonder if there's a simple way of testing whether the CONFIG_ thing
> can *ever* be enabled.  So detect if someone does
> 
> 	if (IS_ENABLED(CONFIG_BLOCKK))

No, not really. There's no simple way to do that.
It's doable, but it's not at all simple.

I think it would require something similar to the
checkpatch seed_camelcase_includes function to look
for all current config symbols and verify whatever
CONFIG_<DEFINE> against that list.

$ git grep -P -oh "^\s*config\s+\w+" -- '*/Kconfig*' | \
  sed -r -e 's/^\s+//' -e 's/\s+/ /g' | \
  sort | uniq -cym

Right now that takes ~1.5 seconds with my laptop
against an uncached git tree, and ~0.25 seconds cached.

Without a git tree it takes 20+ seconds.

Anyway, maybe this.

It only does the time consuming lookup when
it finds a IS_ENABLED line.

---
 scripts/checkpatch.pl | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5f00df2c3f59..aabb01cf1e6c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -47,6 +47,7 @@ my $gitroot = $ENV{'GIT_DIR'};
 $gitroot = ".git" if !defined($gitroot);
 my %debug;
 my %camelcase = ();
+my %Kconfig_syms = ();
 my %use_type = ();
 my @use = ();
 my %ignore_type = ();
@@ -911,6 +912,90 @@ sub is_SPDX_License_valid {
 	return 1;
 }
 
+sub seed_Kconfig_file {
+	my ($file) = @_;
+
+	return if (!(-f $file));
+
+	local $/;
+
+	open(my $Kconfig_file, '<', "$file")
+	    or warn "$P: Can't read '$file' $!\n";
+	my $text = <$Kconfig_file>;
+	close($Kconfig_file);
+
+	my @lines = split('\n', $text);
+
+	foreach my $line (@lines) {
+		next if ($line !~ /^\s*config\s+(\w+)/);
+		$Kconfig_syms{$1} = 1;
+	}
+}
+
+my $Kconfig_symbols_seeded = 0;
+sub seed_Kconfig_symbols {
+	return if ($Kconfig_symbols_seeded);
+
+	my $files;
+	my @Kconfig_files = ();
+	my $Kconfig_syms_cache = "";
+
+	$Kconfig_symbols_seeded = 1;
+
+	if (-e "$gitroot") {
+		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
+		chomp $git_last_include_commit;
+		$Kconfig_syms_cache = ".checkpatch-Kconfig_syms.git.$git_last_include_commit";
+	} else {
+		my $last_mod_date = 0;
+		$files = `find $root/ -name "Kconfig*"`;
+		@Kconfig_files = split('\n', $files);
+		foreach my $file (@Kconfig_files) {
+			my $date = POSIX::strftime("%Y%m%d%H%M",
+						   localtime((stat $file)[9]));
+			$last_mod_date = $date if ($last_mod_date < $date);
+		}
+		$Kconfig_syms_cache = ".checkpatch-Kconfig_syms.date.$last_mod_date";
+	}
+
+	if ($Kconfig_syms_cache ne "" && -f $Kconfig_syms_cache) {
+		open(my $Kconfig_syms_file, '<', "$Kconfig_syms_cache")
+		    or warn "$P: Can't read '$Kconfig_syms_cache' $!\n";
+		while (<$Kconfig_syms_file>) {
+			chomp;
+			$Kconfig_syms{$_} = 1;
+		}
+		close($Kconfig_syms_file);
+
+		return;
+	}
+
+	if (-e "$gitroot") {
+		my @syms = `${git_command} grep -P -oh '^\\s*config\\s+\\w+' -- '*/Kconfig*'`;
+		s/^\s+// for @syms;
+		s/config\s+// for @syms;
+		s/\n$// for @syms;
+		@syms = sort(uniq(@syms));
+		foreach my $sym (@syms) {
+			$Kconfig_syms{$sym} = 1;
+		}
+	} else {
+		foreach my $file (@Kconfig_files) {
+			seed_Kconfig_file($file);
+		}
+	}
+
+	if ($Kconfig_syms_cache ne "") {
+		unlink glob ".checkpatch-Kconfig_syms.*";
+		open(my $Kconfig_syms_file, '>', "$Kconfig_syms_cache")
+		    or warn "$P: Can't write '$Kconfig_syms_cache' $!\n";
+		foreach (sort { lc($a) cmp lc($b) } keys(%Kconfig_syms)) {
+			print $Kconfig_syms_file ("$_\n");
+		}
+		close($Kconfig_syms_file);
+	}
+}
+
 my $camelcase_seeded = 0;
 sub seed_camelcase_includes {
 	return if ($camelcase_seeded);
@@ -6480,6 +6565,22 @@ sub process {
 			}
 		}
 
+# check for IS_ENABLED() used without CONFIG_<FOO> ($rawline for comment use)
+# or if the CONFIG_<FOO> symbol is not a known Kconfig entry
+		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/) {
+			my $sym = $1;
+			seed_Kconfig_symbols();
+		        if ($sym !~ /^CONFIG_/) {
+				WARN("IS_ENABLED_CONFIG",
+				     "IS_ENABLED($sym) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
+			}
+			if (!exists($Kconfig_syms{$sym})) {
+				WARN("IS_ENABLED_CONFIG",
+				     "'$sym' is not a known Kconfig config entry in the current kernel sources\n" . $herecurr);
+
+			}
+		}
+
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
 		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
 			my $config = $1;


