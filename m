Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F9AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C10F20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="uTYEiy/m";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="jtrVt2e+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPLVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:21:45 -0400
Received: from smtp110.ord1c.emailsrvr.com ([108.166.43.110]:39541 "EHLO
        smtp110.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgGPLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:21:44 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 07:21:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594898124;
        bh=T/MnAJmGny+runRexgMA3yXRTrb0zwJfIt7Q+noAQk8=;
        h=Subject:To:From:Date:From;
        b=uTYEiy/mmmqcuzjD3fVqeBi8o79j2rvrww5/hxmrRXIpJ+Q9YkUGuOhTDJJgcTfuf
         4ufLub1MyQsGqYc2nvmzqH0n2OBpUA7bjujniIPGnRjJOBcZ4ZbTnNWysFc5KlbKuY
         Fu2mmHIN6H8NiKwroIXG+Ui6MoCImSZyTTXSsxck=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594898124;
        bh=T/MnAJmGny+runRexgMA3yXRTrb0zwJfIt7Q+noAQk8=;
        h=Subject:To:From:Date:From;
        b=jtrVt2e+Rlvxe/SPvMWUSX7aTwU0xV+22MvOM6P+lx0whtFKK+xE+b+TgA8o1LOww
         jsP1UzHI059/TTJHNTJFnpvuq7AsiTpkHRDpVLSkd0si6kJsWJqceLan4SgyHFbVyz
         tFP40U+ly3c4JzkTUXTLYLTKajdagSGGSyR1i9Gw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 35550E04C2;
        Thu, 16 Jul 2020 07:15:23 -0400 (EDT)
Subject: Re: [PATCH v2] staging: comedi: comedi_fops.c: added casts to get rid
 of sparse warnings
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200715114824.rwqemojowcivbc3z@pesu-pes-edu>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <a2eabb99-82b6-247f-4806-4e564bb0eac3@mev.co.uk>
Date:   Thu, 16 Jul 2020 12:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715114824.rwqemojowcivbc3z@pesu-pes-edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 225dbd0f-4c33-42ef-bdb7-9d3d91d41638-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 12:48, B K Karthik wrote:
> fixed sparse warnings by adding a cast in assignment from
> void [noderef] __user * to unsigned int __force *
> and a reverse cast in argument from
> void [noderef] __user * to  unsigned int __user * .

Minor quibble: the reverse cast is actually from unsigned int * to 
unsigned int __user * .

> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 3f70e5dfac39..9cdc1e8a022d 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
>   	cmd->scan_end_arg = v32.scan_end_arg;
>   	cmd->stop_src = v32.stop_src;
>   	cmd->stop_arg = v32.stop_arg;
> -	cmd->chanlist = compat_ptr(v32.chanlist);
> +	cmd->chanlist = (unsigned int __force *)compat_ptr(v32.chanlist);
>   	cmd->chanlist_len = v32.chanlist_len;
>   	cmd->data = compat_ptr(v32.data);
>   	cmd->data_len = v32.data_len;
> @@ -2983,7 +2983,7 @@ static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
>   	v32.stop_src = cmd->stop_src;
>   	v32.stop_arg = cmd->stop_arg;
>   	/* Assume chanlist pointer is unchanged. */
> -	v32.chanlist = ptr_to_compat(cmd->chanlist);
> +	v32.chanlist = ptr_to_compat((unsigned int __user *)cmd->chanlist);
>   	v32.chanlist_len = cmd->chanlist_len;
>   	v32.data = ptr_to_compat(cmd->data);
>   	v32.data_len = cmd->data_len;
> 

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
