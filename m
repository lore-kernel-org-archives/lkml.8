Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02668C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFF220658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="RU3wQeZ/";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="P7SH4M1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgGOLTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:19:54 -0400
Received: from smtp99.ord1d.emailsrvr.com ([184.106.54.99]:39982 "EHLO
        smtp99.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgGOLTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594811993;
        bh=PfhUjWoGfzXa24bYs69+6jW8ujvkaYrav1deIMbjDzw=;
        h=Subject:To:From:Date:From;
        b=RU3wQeZ/cWGHO9rnyElBfthR6qn+Bjhcvj+GPzwCRFHJXFfkOBmq24RM4TeMyvBNU
         zOCfUZdOp51YSm5uonfVSVQYhl9z33xI1Gbn+pkzG6sCZHqDkt6NTiTwvIk/eCXuQo
         kdiiv6O2PJCQy1p2dVrEAWaW3g8XXpo30KjpU3uE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594811993;
        bh=PfhUjWoGfzXa24bYs69+6jW8ujvkaYrav1deIMbjDzw=;
        h=Subject:To:From:Date:From;
        b=P7SH4M1KfkHWkmuDbTQTIpjh8AVPCtUNqNHdsjhw+9DtsDo6AjE0m6yZkzgxCEBRO
         cPZMbhGlLrR38qWn89cB4VcrO9WWQ4oS4S4lwEtV455ftjyq2LVH/5+LYRzZdhJq+a
         /IadFyNDAoJDffW1O4F85h+QaOwcNwfbSwyn+SjY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BF118C00D9;
        Wed, 15 Jul 2020 07:19:51 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: comedi_fops.c: changed type in
 assignment to unsigned int *
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <4aa4d949-7ef9-ccfe-bf5c-11a380c8f542@mev.co.uk>
Date:   Wed, 15 Jul 2020 12:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 9eceb263-004a-4246-841e-09953c9dc0d2-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 05:48, B K Karthik wrote:
> fixed a sparse warning by changing the type in
> assignment from void [noderef] __user * to unsigned int *
> (different address space)
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 3f70e5dfac39..4cc012e231b7 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
>   	cmd->scan_end_arg = v32.scan_end_arg;
>   	cmd->stop_src = v32.stop_src;
>   	cmd->stop_arg = v32.stop_arg;
> -	cmd->chanlist = compat_ptr(v32.chanlist);
> +	cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);

That should be:

	cmd->chanlist = (unsigned int __force *)compat_ptr(v32.chanlist);

>   	cmd->chanlist_len = v32.chanlist_len;
>   	cmd->data = compat_ptr(v32.data);
>   	cmd->data_len = v32.data_len;
> 

A reverse cast is required in put_compat_cmd():

	v32.chanlist = ptr_to_compat((unsigned int __user *)cmd->chanlist);

Those changes will get rid of the sparse warnings.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
