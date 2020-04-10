Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB70C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C912078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDJRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:35:52 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:26888 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDJRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:35:51 -0400
Received: from [192.168.42.210] ([93.22.39.186])
        by mwinf5d10 with ME
        id R5be2200p40yuPR035bi4L; Fri, 10 Apr 2020 19:35:45 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 10 Apr 2020 19:35:45 +0200
X-ME-IP: 93.22.39.186
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.kernel
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
Date:   Fri, 10 Apr 2020 19:35:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/04/2020 à 04:14, Joe Perches a écrit :
> This works rather better:
>
> Perhaps you could test?
> ---
>
> v2:
>
> o Avoid pr_cont
> o Use only last format line if split across multiple lines
>
>   scripts/checkpatch.pl | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d64c67..f00a6c8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5673,6 +5673,28 @@ sub process {
>   			}
>   		}
>   
> +# check for possible missing newlines at the end of common logging functions
> +		if (defined($stat) &&
> +		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> +		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
> +			my $cnt = statement_rawlines($stat);
> +			my $extracted_string = "";
> +			for (my $i = 0; $i < $cnt; $i++) {
> +				next if ($lines[$linenr + $i - 1] !~ /$String\s*[,\)]/);
> +				$extracted_string = get_quoted_string($lines[$linenr + $i - 1],
> +								      $rawlines[$linenr + $i - 1]);
> +				last if ($extracted_string ne "");
> +			}
> +			if ($extracted_string ne "" && $extracted_string !~ /\\n"$/) {
> +				my $herectx = $here . "\n";
> +				for (my $n = 0; $n < $cnt; $n++) {
> +					$herectx .=  raw_line($linenr, $n) . "\n";
> +				}
> +				WARN("MISSING_FORMAT_NEWLINE",
> +				     "Possible missing '\\n' at the end of a logging message format string\n" . $herectx);
> +			}
> +		}
> +
>   # check for logging functions with KERN_<LEVEL>
>   		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
>   		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {


Hi,

I'm looking at some modification done in the last month that could have 
been spotted by the above script.

     ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c

correctly spots the 3 first cases, but the 3 last (line 202, 210 and 
217) are missed.
I don't understand why.

CJ

