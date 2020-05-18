Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A43C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D246620709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EH+gpxtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgERN1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:27:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44468 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:27:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IDR0k6045161;
        Mon, 18 May 2020 13:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BCGosJHcbcUtce4Hxg02+p38p5RdXX0moe9TSLTeZGQ=;
 b=EH+gpxtAPFyj5QeBSa5jhy+E/Rx23WKIT0T9TAicRU2pvtwcI75sQpBVVBvW3Xm5dfZW
 hxYu0ZQ38W0e9C42My9dRMBYGMFD34h7+d6if5yVnVtxTnE2rdifnr6W3WTJ/8vu+oGU
 utc4PkvEskNy2xWT/VSxfxjwA1AuidCfQBSKKS31KjzwbALLQudOdjL/KWnci0a2WdGX
 nM5pUE0LYFE1+1DmL1MUwsC07VkTlRyJM5BBn5NM+zBrPxfKMHMJt29rKxZHU4eO5zs8
 xgqr27U0RubvYJ+1zfEwGakzooe+hP1bVfBTOG7fo1cLCuwqrkOd6BdGUGzT4DSwgFlg wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kqxrat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 13:27:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IDOUs4108508;
        Mon, 18 May 2020 13:25:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 313ghyusxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 13:25:30 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04IDPTlA004663;
        Mon, 18 May 2020 13:25:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 06:25:29 -0700
Date:   Mon, 18 May 2020 16:25:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Merge almost duplicate code
Message-ID: <20200518132523.GK2078@kadam>
References: <20200517165819.136715-1-pterjan@google.com>
 <CAANdO=Li7FUbVQk6m+CksZBv1zy-F+-1tN9oYZ4niYJ0utRfXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAANdO=Li7FUbVQk6m+CksZBv1zy-F+-1tN9oYZ4niYJ0utRfXA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 09:25:05PM +0100, Pascal Terjan wrote:
> On Sun, 17 May 2020 at 17:58, Pascal Terjan <pterjan@google.com> wrote:
> >
> > This causes a change in behaviour:
> > - stats also get updated when reordering, this seems like it should be
> >   the case but those lines were commented out.
> > - sub_skb NULL check now happens early in both cases, previously it
> >   happened only after dereferencing it 12 times, so it may not actually
> >   be needed.
> >
> 
> Hi,
> I actually noticed the same duplicated code (and same late NULL check)
> in drivers/staging/rtl8192e/rtllib_rx.c
> drivers/staging/rtl8712/rtl8712_recv.c has only one copy of the code
> but with the late NULL check
> drivers/staging/rtl8188eu/core/rtw_recv.c has only one copy of the
> code and doesn't do any NULL check
> 
> Now I wonder how to proceed. The code is not great so it would not
> feel right to make it reusable.
> Should I continue improving it on this driver only first (maybe trying
> to reuse ieee80211_data_to_8023_exthdr from net/wireless/util.c for
> example)?

It looks like the NULL check could be removed, but it's also fine to
keep it so long as it's not after a NULL dereference.

Do whatever you have the energy to do...  It would be nice if people who
fix bugs in these Realtek drivers would check the other drivers as well
but for cleanups basically everyone just works on one driver only.

regards,
dan carpenter

