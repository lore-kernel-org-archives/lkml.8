Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ADCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61FC20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593675754;
	bh=CoV32QaALDuL3Z9VEXeQEpQ4T+p6a2AGF/RZFvRe4v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rwxd4tlRZIl2Joz0XsxQRPR9MymRpHk0swOeQ88IA1VVqWifyQx5PK8/Un3o3OUNv
	 X1uu5EUs7Wh9OdLlG7ng2osgxXuWKXgJ33qtmFpwcJaxEcY3j4fcp4ek9XdkHrezs8
	 2mCGD3TqcJgOec3benM04C2lGDqt3b9xtwMKgPHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGBHmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgGBHmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:42:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D203120899;
        Thu,  2 Jul 2020 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593675751;
        bh=CoV32QaALDuL3Z9VEXeQEpQ4T+p6a2AGF/RZFvRe4v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCiET5Q7Iut6jzjunUHexrG6hKhXFTRFsgr4+T1BP38b8zkD8sSPUs2/q59n7oyx4
         Qi5PRHO0DYzs7ce6Odwa9fhkoAdFXYIG36DUEWWl9JBrr4u5STywCNKqwaywpYGM0f
         J5UnovdfXxzZL0zbSyL6ZxfmuahIf/kSL8K/p8y8=
Date:   Thu, 2 Jul 2020 09:42:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 7/8] ktest.pl: Add the log of last test in
 email on failure
Message-ID: <20200702074235.GB1076415@kroah.com>
References: <20200701231717.757834010@goodmis.org>
 <20200701231756.619246244@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701231756.619246244@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 07:17:24PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If a failure happens and an email is sent, show the contents of the log of
> the last test that failed in the email.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/testing/ktest/ktest.pl | 44 ++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index e90e2e7cb72c..945a7d8c178c 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -82,6 +82,8 @@ my %default = (
>      "IGNORE_UNUSED"		=> 0,
>  );
>  
> +my $test_log_start = 0;
> +
>  my $ktest_config = "ktest.conf";
>  my $version;
>  my $have_version = 0;
> @@ -1492,8 +1494,21 @@ sub dodie {
>  
>      if ($email_on_error) {
>  	my $name = get_test_name;
> +	my $log_file;
> +
> +	if (defined($opt{"LOG_FILE"})) {
> +	    $log_file = "$tmpdir/log";
> +	    open (L, "$opt{LOG_FILE}") or die "Can't open $opt{LOG_FILE} to read)";
> +	    open (O, "> $tmpdir/log") or die "Can't open $tmpdir/log\n";
> +	    seek(L, $test_log_start, 0);
> +	    while (<L>) {
> +		print O;
> +	    }
> +	    close O;
> +	    close L;
> +	}
>          send_email("KTEST: critical failure for test $i [$name]",
> -                "Your test started at $script_start_time has failed with:\n@_\n");
> +                "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
>      }
>  
>      if ($monitor_cnt) {
> @@ -4185,7 +4200,7 @@ sub find_mailer {
>  }
>  
>  sub do_send_mail {
> -    my ($subject, $message) = @_;
> +    my ($subject, $message, $file) = @_;
>  
>      if (!defined($mail_path)) {
>  	# find the mailer
> @@ -4195,22 +4210,37 @@ sub do_send_mail {
>  	}
>      }
>  
> +    my $header_file = "$tmpdir/header";
> +    open (HEAD, ">$header_file") or die "Can not create $header_file\n";
> +    print HEAD "To: $mailto\n";
> +    print HEAD "Subject: $subject\n\n";
> +    print HEAD "$message\n";
> +    close HEAD;
> +
>      if (!defined($mail_command)) {
>  	if ($mailer eq "mail" || $mailer eq "mailx") {
> -	    $mail_command = "\$MAIL_PATH/\$MAILER -s \'\$SUBJECT\' \$MAILTO <<< \'\$MESSAGE\'";
> +	    $mail_command = "cat \$HEADER_FILE \$BODY_FILE | \$MAIL_PATH/\$MAILER -s \'\$SUBJECT\' \$MAILTO";
>  	} elsif ($mailer eq "sendmail" ) {
> -	    $mail_command =  "echo \'Subject: \$SUBJECT\n\n\$MESSAGE\' | \$MAIL_PATH/\$MAILER -t \$MAILTO";
> +	    $mail_command =  "cat \$HEADER_FILE \$BODY_FILE | \$MAIL_PATH/\$MAILER -t \$MAILTO";
>  	} else {
>  	    die "\nYour mailer: $mailer is not supported.\n";
>  	}
>      }
>  
> +    if (defined($file)) {
> +	$mail_command =~ s/\$BODY_FILE/$file/g;
> +    } else {
> +	$mail_command =~ s/\$BODY_FILE//g;
> +    }
> +
> +    $mail_command =~ s/\$HEADER_FILE/$header_file/g;
>      $mail_command =~ s/\$MAILER/$mailer/g;
>      $mail_command =~ s/\$MAIL_PATH/$mail_path/g;
>      $mail_command =~ s/\$MAILTO/$mailto/g;
>      $mail_command =~ s/\$SUBJECT/$subject/g;
>      $mail_command =~ s/\$MESSAGE/$message/g;
>  
> +	    print ">$mail_command<\n";
>      run_command $mail_command;
>  }
>  
> @@ -4352,6 +4382,11 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
>      }
>  
>      doprint "\n\n";
> +
> +    if (defined($opt{"LOG_FILE"})) {
> +	$test_log_start = tell(LOG);
> +    }

Nit, the mix of spaces and tabs in this file is always annoying to me,
but it's your code...

> +
>      doprint "RUNNING TEST $i of $opt{NUM_TESTS}$name with option $test_type $run_type$installme\n\n";
>  
>      if (defined($pre_test)) {
> @@ -4461,6 +4496,7 @@ if ($email_when_finished) {
>  }
>  
>  if (defined($opt{"LOG_FILE"})) {
> +
>      print "\n See $opt{LOG_FILE} for the record of results.\n\n";
>      close LOG;
>  }

Extra blank line?

Anyway, looks sane to me

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
