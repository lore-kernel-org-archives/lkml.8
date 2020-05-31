Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C985C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3572074B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgEaRhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:37:06 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:35164 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728175AbgEaRhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:37:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7F546837F253;
        Sun, 31 May 2020 17:37:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cup30_260de1426d76
X-Filterd-Recvd-Size: 2605
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 May 2020 17:37:01 +0000 (UTC)
Message-ID: <24e0f572511724ea338f8802fde2ad3a359ea8d5.camel@perches.com>
Subject: Re: [PATCH] staging:r8723bs: remove wrappers around skb_clone()
From:   Joe Perches <joe@perches.com>
To:     Ivan Safonov <insafonov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lukasz Szczesny <luk@wybcz.pl>, R Veera Kumar <vkor@vkten.in>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 31 May 2020 10:36:59 -0700
In-Reply-To: <8e4df253-e021-6c29-96ab-24eed9b61eb2@gmail.com>
References: <20200531160843.39120-1-insafonov@gmail.com>
         <7bf8612d3708b811e026daec5c7a1486c5954905.camel@perches.com>
         <8e4df253-e021-6c29-96ab-24eed9b61eb2@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-31 at 20:28 +0300, Ivan Safonov wrote:
> On 5/31/20 7:15 PM, Joe Perches wrote:
> > On Sun, 2020-05-31 at 19:08 +0300, Ivan Safonov wrote:
> > > Wrappers around skb_clone() do not simplify the driver code.
> > []
> > > -inline struct sk_buff *_rtw_skb_clone(struct sk_buff *skb)
> > > -{
> > > -	return skb_clone(skb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
> > > -}
> > > -
> > []
> > > diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> > []
> > > @@ -110,7 +110,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
> > >   			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
> > >   				if (bmcast) {
> > >   					psta = rtw_get_bcmc_stainfo(padapter);
> > > -					pskb2 = rtw_skb_clone(pkt);
> > > +					pskb2 = skb_clone(pkt, GFP_ATOMIC);
> > 
> > Why make every clone allocation GFP_ATOMIC ?
> 
> The rtw_os_recv_indicate_pkt() is always called from an interrupt handler.

It'd be better to indicate you know that in the changelog
as the subject and changelog just shows removing wrappers
and the patch code does not agree with that.



