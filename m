Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B19C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9928B2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbgDNQEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:04:07 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:37068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388149AbgDNQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:03:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7AA5E18016BAA;
        Tue, 14 Apr 2020 16:03:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hope66_1e399ae4d9553
X-Filterd-Recvd-Size: 5838
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Apr 2020 16:03:27 +0000 (UTC)
Message-ID: <d3725a08531898adc1bfb1e6d875888c434b42d6.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     gregkh@linuxfoundation.org, navid.emamdoost@gmail.com,
        sylphrenadin@gmail.com, nishkadg.linux@gmail.com,
        stephen@brennan.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Date:   Tue, 14 Apr 2020 09:01:18 -0700
In-Reply-To: <20200414123326.GG1163@kadam>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
         <20200414123326.GG1163@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 15:33 +0300, Dan Carpenter wrote:
> On Mon, Apr 13, 2020 at 03:01:28AM +0000, Camylla Goncalves Cantanheide wrote:
> > Changes of the local variable value and
> > modification in the seletive repetition structure.
> > 
> 
> This changelog isn't totally clear why you're doing this.  Just say:
> "I am refactorying setKey() to make it more clear.  I have unrolled the
> first two iterations through the loop.  This patch will not change
> runtime."
> 
> So long as it's clear what you're trying to do and why, that's the
> important thing with a commit message.
> 
> > Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U_core.c | 52 ++++++++++++--------------
> >  1 file changed, 24 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> > index 9b8d85a4855d..87c02aee3854 100644
> > --- a/drivers/staging/rtl8192u/r8192U_core.c
> > +++ b/drivers/staging/rtl8192u/r8192U_core.c
> > @@ -4880,7 +4880,7 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
> >  void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
> >  	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
> >  {
> > -	u32 target_command = 0;
> > +	u32 target_command = CAM_CONTENT_COUNT * entryno |  BIT(31) | BIT(16);
> >  	u32 target_content = 0;
> >  	u16 us_config = 0;
> >  	u8 i;
> > @@ -4890,39 +4890,35 @@ void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
> >  
> >  	RT_TRACE(COMP_SEC,
> >  		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
> > -        	 __func__, dev, entryno, keyindex, keytype, macaddr);
> > +		 __func__, dev, entryno, keyindex, keytype, macaddr);
> 
> Do this white space change in a separate patch.
> 
> >  
> >  	if (defaultkey)
> >  		us_config |= BIT(15) | (keytype << 2);
> >  	else
> >  		us_config |= BIT(15) | (keytype << 2) | keyindex;
> >  
> > -	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
> > -		target_command  = i + CAM_CONTENT_COUNT * entryno;
> > -		target_command |= BIT(31) | BIT(16);
> > -
> > -		if (i == 0) { /* MAC|Config */
> > -			target_content = (u32)(*(macaddr + 0)) << 16 |
> > -					(u32)(*(macaddr + 1)) << 24 |
> > -					(u32)us_config;
> > -
> > -			write_nic_dword(dev, WCAMI, target_content);
> > -			write_nic_dword(dev, RWCAM, target_command);
> > -		} else if (i == 1) { /* MAC */
> > -			target_content = (u32)(*(macaddr + 2))	 |
> > -					(u32)(*(macaddr + 3)) <<  8 |
> > -					(u32)(*(macaddr + 4)) << 16 |
> > -					(u32)(*(macaddr + 5)) << 24;
> > -			write_nic_dword(dev, WCAMI, target_content);
> > -			write_nic_dword(dev, RWCAM, target_command);
> > -		} else {
> > -			/* Key Material */
> > -			if (keycontent) {
> > -				write_nic_dword(dev, WCAMI,
> > -						*(keycontent + i - 2));
> > -				write_nic_dword(dev, RWCAM, target_command);
> > -                	}
> > -		}
> > +	target_content = macaddr[0] << 16 |
> > +			 macaddr[0] << 24 |
> > +			(u32)us_config;
> > +
> > +	write_nic_dword(dev, WCAMI, target_content);
> > +	write_nic_dword(dev, RWCAM, target_command++);
> > +
> > +	/* MAC */
> > +	target_content = macaddr[2]	  |
> > +			 macaddr[3] <<  8 |
> > +			 macaddr[4] << 16 |
> > +			 macaddr[5] << 24;
> > +	write_nic_dword(dev, WCAMI, target_content);
> > +	write_nic_dword(dev, RWCAM, target_command++);
> > +
> > +	/* Key Material */
> > +	if (!keycontent)
> > +		return;
> > +
> > +	for (i = 2; i < CAM_CONTENT_COUNT; i++) {
> > +		write_nic_dword(dev, WCAMI, *keycontent++);
> 
> This code was wrong in the original as well, but now that I see the bug
> let's fix it.  CAM_CONTENT_COUNT is 8.  8 - 2 = 6.  We are writing 6
> u32 variables to write_nic_dword().  But the *keycontent buffer only has
> 4 u32 variables so it is a buffer overflow.

Did you find the overflow with smatch?

Perhaps this but it'll write 0's for the
last couple cam entries instead of random
address values.

Dunno what effect that'd have.  Likely none.

---
 drivers/staging/rtl8192u/r8192U_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 100532..923c0c 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -733,7 +733,7 @@ static int r8192_wx_set_enc_ext(struct net_device *dev,
 	{
 		u8 broadcast_addr[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 		u8 zero[6] = {0};
-		u32 key[4] = {0};
+		u32 key[6] = {0};
 		struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
 		struct iw_point *encoding = &wrqu->encoding;
 		u8 idx = 0, alg = 0, group = 0;



