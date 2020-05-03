Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1BC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB99E20787
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPy9GLl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgECMmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgECMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:41:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00538C061A0C;
        Sun,  3 May 2020 05:41:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so2421835pju.2;
        Sun, 03 May 2020 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=26JhLNWEI7jS5emKz4ATnhzzFH8XDenxaWgLiomlOeY=;
        b=YPy9GLl7PeY/VbAy+rtrCYKEMCSd1i+TZOUYQT0HFRKiCdGaXv634BBawJ1e5THmfL
         eh67Lrdrtv/MaTt5a86VEMk8Uib7dYBnBAPdXzVUnJe/yd00z1evetp6VYrHG/auoNaU
         +t15IHPPtYI1yhtnXi+16ryuQDqkKZViWFcQHlcjzdomsAkERQ2hBoZIoAFF3XrzcuyF
         KAX/QRaId8NjW0bs1t5GRLU9e/UfGISY/s4eUE9JArpkKMM9KjNCYQoGW/RaA4Nr4Y1q
         rjBEIbLHyuWYbIf5vYvTj9nr0bNribrbIFXSWiUinJiIljOppQHGYT3sZsf494+SyRLO
         4ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=26JhLNWEI7jS5emKz4ATnhzzFH8XDenxaWgLiomlOeY=;
        b=c2UW2xibCRU4AptGAdbSUGR60kSu5Z1BSRFxQWNnwzP2pg9nEWzInxQM+ZTizeHR2m
         Dzh/Xf1x4h4FZG4l+IsB1AWinEzMUYfkZxG77ZTDQIb1WmPKpMGDUyEHgri7wkyMBQqv
         XeHm9EBQZ4UBTWyG0Zrdega1RCA2ypXK56tNe3ciE2O8ZB5MGY9DkqZhDAm838SXqBYY
         +xlc2WVwD17KMpCdGzvp12W88bTYMpW1CEODk1SzJKSPDtqCPCcki3vTs/HZ/8EHhns/
         eXdm/O7Fzh5zdOwkC+DuyG7wEwSnGQVSGH2pQfbXXuNIzetIF/Q9ck1/3qznGov/v4Ph
         XA+w==
X-Gm-Message-State: AGi0PuaTaxRrOkTG92g53YTyq7DlqYYFrXzA3SzvnBg135T0FSMtJIRD
        o1dk6lnQJzUBEbcPPopON4o=
X-Google-Smtp-Source: APiQypKsxYR1wIihI41SbkcLyESu/qGqurUARiu7u6Gw8UlAf8pcqWo04JAzEp2UVJLCVs1Y0lvs+Q==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr14028869plr.16.1588509698515;
        Sun, 03 May 2020 05:41:38 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id d74sm6512030pfd.70.2020.05.03.05.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 05:41:37 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 043CYZlr011084;
        Sun, 3 May 2020 20:34:35 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 043CYZiM011083;
        Sun, 3 May 2020 20:34:35 +0800
Date:   Sun, 3 May 2020 20:34:35 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     joe@perches.com
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] checkpatch: add support for title acrosses three lines in
 commit id description
Message-ID: <20200503123435.GD10332@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, joe@perches.com,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current GIT_COMMIT_ID will report error when the title in commit id
description acrosses three lines, take changelog of commit 87b0f983f66f
("net: mscc: ocelot: fix untagged packet drops when enslaving to vlan
aware bridge") as a example.

It make senses to support three lines title, because three lines could only
have about two lines length title, see above example, but I think we don't
need to add support for more than three lines length title, ~225 (75 * 3)
shoud be enough for any sensible title.

This patch adds support for three lines title in the commit id description,
and emit diagnostics info when the title acrosses more than three lines.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Hi! Joe
 This is the third patch based on previous two patches.

 Thanks.
 
 scripts/checkpatch.pl | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a1e4113..e9c46d3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2899,15 +2899,27 @@ sub process {
 				$orig_desc = $1;
 				$has_parens_and_dqm = 1;
 			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\(".+$/i &&
-				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
-				$line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("(.+)$/i;
-				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
-				$orig_desc .= " " . $1;
-				$has_parens_and_dqm = 1;
-
-				if ($prefix eq "Fixes:") {
+				 defined $rawlines[$linenr]) {
+				 if ($rawlines[$linenr] =~ /^\s*.+"\)/) {
+					$line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("(.+)$/i;
+					$orig_desc = $1;
+					$rawlines[$linenr] =~ /^\s*(.+)"\)/;
+					$orig_desc .= " " . $1;
+					$has_parens_and_dqm = 1;
+				 } elsif (defined $rawlines[$linenr + 1] &&
+					  $rawlines[$linenr + 1] =~ /^\s*.+"\)/) {
+					$line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("(.+)$/i;
+					$orig_desc = $1;
+					$rawlines[$linenr] =~ /^\s*(.+)/;
+					$orig_desc .= " " . $1;
+					$rawlines[$linenr + 1] =~ /^\s*(.+)"\)/;
+					$orig_desc .= " " . $1;
+					$has_parens_and_dqm = 1;
+				 } else {
+					$diagnostics .= "Missing terminal '\")' at the end of title or the title acrosses more than 3 lines.\n";
+				 }
+
+				if ($has_parens_and_dqm && $prefix eq "Fixes:") {
 					$acrosslines = 1;
 					$diagnostics .= "The title acrosses lines.\n";
 				}
-- 
1.8.5.6.2.g3d8a54e.dirty
