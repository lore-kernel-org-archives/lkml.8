Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D40C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC47C20784
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO2rHneN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgC3WdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:33:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54873 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbgC3WdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585607581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvgEeFjtAh1QWGoc60hjoonPbLbA3KJyXugPITzRpSc=;
        b=TO2rHneNS0KldRS8OU0qcU+Sn/kI84AinnqDjAXFkuo1piq0mPCEHXijW12iab9kbTBTsO
        5SSHuYFEDAM2/51/BWDMhF5Klz1jMYcyhLbK1fx3VJMSTJC8fixxJ2VA86Hx2413Aqg/8N
        JOr8m8luKB8/yIVrClA8L2gvaXfyIhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-rmPQzsmXOOCvOv3gMS0LeA-1; Mon, 30 Mar 2020 18:32:57 -0400
X-MC-Unique: rmPQzsmXOOCvOv3gMS0LeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B86800D50;
        Mon, 30 Mar 2020 22:32:55 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D13996EFA4;
        Mon, 30 Mar 2020 22:32:51 +0000 (UTC)
Date:   Tue, 31 Mar 2020 00:32:44 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] staging: vt6656: add error code handling to unused
 variable
Message-ID: <20200331003244.4e9f5ce2@elisabeth>
In-Reply-To: <61bb6678d48557895671488357a62680d0ae655f.camel@gmail.com>
References: <20200330214613.31078-1-jbwyatt4@gmail.com>
        <20200331000143.7c8f98c0@elisabeth>
        <61bb6678d48557895671488357a62680d0ae655f.camel@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 15:26:04 -0700
"John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:

> On Tue, 2020-03-31 at 00:01 +0200, Stefano Brivio wrote:
> > On Mon, 30 Mar 2020 14:46:13 -0700
> > "John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:
> >   
> > > Add error code handling to unused 'ret' variable that was never
> > > used.
> > > Return an error code from functions called within
> > > vnt_radio_power_on.
> > > 
> > > Issue reported by coccinelle (coccicheck).
> > > 
> > > Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > > Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> > > Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > > ---
> > > v6: Forgot to add all the v5 code to commit.
> > > 
> > > v5: Remove Suggested-by: Julia Lawall above seperator line.
> > > 	Remove break; statement in switch block.
> > > 	break; removal checked by both gcc compile and checkpatch.
> > > 	Suggested by Stefano Brivio <sbrivio@redhat.com>
> > > 
> > > v4: Move Suggested-by: Julia Lawall above seperator line.
> > >     Add Reviewed-by tag as requested by Quentin Deslandes.
> > > 
> > > v3: Forgot to add v2 code changes to commit.
> > > 
> > > v2: Replace goto statements with return.
> > >     Remove last if check because it was unneeded.
> > >     Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > 
> > >  drivers/staging/vt6656/card.c | 20 ++++++++++++--------
> > >  1 file changed, 12 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vt6656/card.c
> > > b/drivers/staging/vt6656/card.c
> > > index dc3ab10eb630..c947e8188384 100644
> > > --- a/drivers/staging/vt6656/card.c
> > > +++ b/drivers/staging/vt6656/card.c
> > > @@ -723,9 +723,13 @@ int vnt_radio_power_on(struct vnt_private
> > > *priv)
> > >  {
> > >  	int ret = 0;
> > >  
> > > -	vnt_exit_deep_sleep(priv);
> > > +	ret = vnt_exit_deep_sleep(priv);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > > -	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
> > > +	ret = vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	switch (priv->rf_type) {
> > >  	case RF_AL2230:
> > > @@ -734,14 +738,14 @@ int vnt_radio_power_on(struct vnt_private
> > > *priv)
> > >  	case RF_VT3226:
> > >  	case RF_VT3226D0:
> > >  	case RF_VT3342A0:
> > > -		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> > > -				    (SOFTPWRCTL_SWPE2 |
> > > SOFTPWRCTL_SWPE3));
> > > -		break;
> > > +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> > > +					  (SOFTPWRCTL_SWPE2 | 
> > > +					  SOFTPWRCTL_SWPE3));
> > >  	}
> > > +	if (ret)
> > > +		return ret;  
> > 
> > Hmm, sorry, I haven't been clear enough I guess.
> > 
> > This is what you're doing:
> > 
> > if rf_type is not in that list:
> > - set some bits in a register
> > - did it fail? return
> > - did it fail? return
> > ...
> > 
> > if rf_type is in that list:
> > - set some bits in a register
> > - did it fail? return
> > - set some other bits
> > - did it fail? return
> > ...
> > 
> > Now, the "set some other bits" part is already selected depending on
> > rf_type. There's no need to check 'ret' otherwise, so you can move
> > the
> > return just after setting 'ret', in the switch case.
> >   
> 
> Thank you for pointing that out Stefano. That would be a serious issue
> with logic.
> 
> Just to be sure. Are you looking for this?
> 
> switch (priv->rf_type) {
> case RF_AL2230:
> case RF_AL2230S:
> case RF_AIROHA7230:
> case RF_VT3226:
> case RF_VT3226D0:
> case RF_VT3342A0:
> 	ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> 				  (SOFTPWRCTL_SWPE2 | 
> 				  SOFTPWRCTL_SWPE3));
> 	if (ret)
> 		return ret;
> }

Exactly.

> > With a check, because you don't want to return if ret == 0.
> >   
> 
> What do you mean exactly by this?

Exactly what you wrote above: if (ret) ...

> The new code should only return a 0 at the end of the function with the
> vnt_mac_reg_bits_off call.

That, or an error code if vnt_mac_reg_bits_off() fails.

-- 
Stefano

