Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A962070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgCZMTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:19:23 -0400
Received: from ciao.gmane.io ([159.69.161.202]:56584 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCZMTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:19:23 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jHRTl-000CLv-VZ
        for linux-kernel@vger.kernel.org; Thu, 26 Mar 2020 13:19:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/2] SUNRPC: Optimize 'svc_print_xprts()'
Date:   Thu, 26 Mar 2020 13:19:12 +0100
Message-ID: <2e2d1293-c978-3f1d-5a1e-dc43dc2ad06b@wanadoo.fr>
References: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr>
 <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com>
 <42afbf1f-19e1-a05c-e70c-1d46eaba3a71@wanadoo.fr>
 <87wo786o80.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <87wo786o80.fsf@notabene.neil.brown.name>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/03/2020 à 23:53, NeilBrown a écrit :
> Can I suggest something more like this:
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index de3c077733a7..0292f45b70f6 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -115,16 +115,9 @@ int svc_print_xprts(char *buf, int maxlen)
>   	buf[0] = '\0';
>   
>   	spin_lock(&svc_xprt_class_lock);
> -	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
> -		int slen;
> -
> -		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, xcl->xcl_max_payload);
> -		slen = strlen(tmpstr);
> -		if (len + slen > maxlen)
> -			break;
> -		len += slen;
> -		strcat(buf, tmpstr);
> -	}
> +	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list)
> +		len += scnprintf(buf + len, maxlen - len, "%s %d\n",
> +				 xcl->xcl_name, xcl->xcl_max_payload);
>   	spin_unlock(&svc_xprt_class_lock);
>   
>   	return len;
>
> NeilBrown

Hi,

this was what I suggested in the patch:
     ---
     This patch should have no functional change.
     We could go further, use scnprintf and write directly in the 
destination
     buffer. However, this could lead to a truncated last line.
     ---

And Chuck Lever confirmed that:
     That's exactly what this function is trying to avoid. As part of any
     change in this area, it would be good to replace the current block
     comment before this function with a Doxygen-format comment that
     documents that goal.

So, I will only send a V2 based on comments already received.

CJ


