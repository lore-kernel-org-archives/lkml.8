Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D67C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE1320734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="y1xYn0NF";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="NBq/h2H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgGQJr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:47:59 -0400
Received: from smtp89.iad3b.emailsrvr.com ([146.20.161.89]:48824 "EHLO
        smtp89.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgGQJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594979277;
        bh=WXkjnIO94DrrmTRmi3QBp3/Lh0Il+Vz6algDOKksuBc=;
        h=Subject:To:From:Date:From;
        b=y1xYn0NFBkJeaNCBBUotm4z1kwx472qTs/IhTRVjU7TFEv48y/kqYkL3H37YGVaT4
         zbskUISJ6TKIGxDHnyI4ULmYkUVd0lLAcqZj9gxoU8NSMhT6ABn0bAtKjVMA3JO8Y6
         GqXRzIN4+tuIw4w8H5STbEhE+aRCKhzfYXwOS0mo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594979277;
        bh=WXkjnIO94DrrmTRmi3QBp3/Lh0Il+Vz6algDOKksuBc=;
        h=Subject:To:From:Date:From;
        b=NBq/h2H4SwIN245gkZoKtTMMwrEhv5o+IknLSfP7s4Pk4LEznd7I8a8vF1eTfkzLS
         I40kzzTQ/DZoZwgMgLthHxn9LXC5nNPyzf1sfH6Xifd2sFZnDk3l7diaA2jEKvCHkD
         ijsxkJYza/b4tYhQVeu/yHyAkxnWGN6TSqy3Z4Eg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5886420080;
        Fri, 17 Jul 2020 05:47:56 -0400 (EDT)
Subject: Re: [PATCH v4] staging: comedi: comedi_fops.c: added casts to get rid
 of sparse warnings
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200716152548.mzau4zhurwkzp5p6@pesu-pes-edu>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <8afee168-b65c-dafe-59f6-32d1c59d87dc@mev.co.uk>
Date:   Fri, 17 Jul 2020 10:47:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716152548.mzau4zhurwkzp5p6@pesu-pes-edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 2d6a9683-da48-406f-a750-e911abcb7c7b-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 16:25, B K Karthik wrote:
> fixed sparse warnings by adding a cast in assignment from
> void [noderef] __user * to unsigned int __force *
> and a reverse cast in argument from
> unsigned int * to  unsigned int __user * .
> 
> v1 -> v2:
> - Add a reverse cast in argument
> v2 -> v3:
> - Change commit description as suggested by Ian Abott
> v3 -> v4:
> - Add versioning information in commit description

For future reference, the patch change history should go below the "---" 
divider line below where git will ignore it so that it does not appear 
in the final commit description.  Otherwise, the committer would need to 
edit it out manually.

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

Still looks good.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
