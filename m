Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB5C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD6212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/4NOfJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgCSPHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:07:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55468 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgCSPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:07:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JEwwgE124196;
        Thu, 19 Mar 2020 15:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tEtZwW7IpOSLSvQnsgQ8J66cJvp62R3ApNSmRuGT2WQ=;
 b=O/4NOfJOo9aAmZNgtfpBkmebfoNeXdUSGWKDSaPJAG2VVWaDHsbfaIhyeVNcHjoK94Kv
 OJ98WJEs3tcFgvQmtSIaYPkvApBpXGGI9LX/PaHYLkbukt8og1hjbj/ZAvZNmUi7m6Y+
 sP+s1zfx6uf2OSSOylP3PX2Tp/tCrrH+fjK8QLXeuDl6xVUoJcdu4v3ph9B8VhoMnSEV
 jBsmMnJtwjV7gfqVKVfx5njwf5zRz0JgH498L94OKhJoGk01lcqAvzk7clAudGyhjpGs
 xidrCBNirB0N0ATxPYMXBWOJ2pBZQyvJvp6rAjKnz8Jct1cVVdLlFsUx64sdacYkz+65 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yrpprgwf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:07:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JEv5tt185228;
        Thu, 19 Mar 2020 15:07:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ys8tw5xt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:07:15 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JF7EUX002914;
        Thu, 19 Mar 2020 15:07:14 GMT
Received: from [10.39.245.129] (/10.39.245.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 08:07:14 -0700
Subject: Re: [PATCH] xen-pciback: fix INTERRUPT_TYPE_* defines
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200319040648.10396-1-marmarek@invisiblethingslab.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <e6c48552-9866-497c-7d2f-62849122f867@oracle.com>
Date:   Thu, 19 Mar 2020 11:07:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319040648.10396-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=847 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=912 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/20 12:06 AM, Marek Marczykowski-Górecki wrote:
> INTERRUPT_TYPE_NONE should be 0,


Would

   return ret ?: INTERRUPT_TYPE_NONE

in xen_pcibk_get_interrupt_type() work?


I think it's better not to tie macro name to a particular value.


-boris


>   as it is assumed in
> xen_pcibk_get_interrupt_type(). Fix the definition, and also shift other
> values to not leave holes.
> But also use INTERRUPT_TYPE_NONE in xen_pcibk_get_interrupt_type() to
> avoid similar confusions in the future.
>
> Fixes: 476878e4b2be ("xen-pciback: optionally allow interrupt enable flag writes")
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
>
>   
