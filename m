Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68BFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C4E20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3CWQRj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgC3XcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:32:25 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33393 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgC3XcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:32:24 -0400
Received: by mail-pj1-f65.google.com with SMTP id jz1so362255pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YmXm/3/ySoSCBdXTqKuN6yVAH5JMGZyG+4nCFBPekZ4=;
        b=q3CWQRj70zrECqtoVIaTOe9sA36DTH/LGFpudFW5IX+5PnRdFac9wnVrcA7JGuE7nP
         8weINSeAB/jP5eihsW7Qv19Fkr/Eh0iR56JjkJ6SGKLFpUv6VKYu45d2fiuZ9jt3FV1s
         OS8cdNPbJzOOu4KQpg/vuVUI3Z+ehIazsEnmzw6FknP45MBj0E7XBCUTimH7NVk6WmBV
         22gkhmg/GWoo0CYb9fRu2vf6j2+kuuZtL+abU2dNCapI2hkoCNC47SZ+IfRhKS5xBeS2
         W5NrfzK0KWKis7g/69eSkhqKjqcxjnjuD+V0vjTlPAC69lnwK32Kgbx4kXlJdarHMMYS
         RQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YmXm/3/ySoSCBdXTqKuN6yVAH5JMGZyG+4nCFBPekZ4=;
        b=uIxwZ1u8D1fddx4GgvFXIglXZar4d2eIReRMZhnMf6w6MGxk8F2/Ne0gEzzXyvlJaA
         Jup/FwdYoPbi5m9nCjXcrVt7OnKmHU6IcDfw1xD6n7/aTpdGW6AwN/oOPVp6nHpcyapP
         czJRmdXLk5TbgxS3ieOfxoVJwTRcWamtS6iesoYNlvWq7Q8Vhw4FptKkpnFOMPGP5/cM
         3EtPHk7phdOKm9wyc5bSbtEVVNzEZk7A7IbFZoUdk/OVv0nYI2Ld1mieHb2SDiVNAkg4
         PcgzPay7senpGYBtMc2020Oqew+uidTXLw+sLkGLoJxdkZcKUTyulw4eTw2Tso2I+jOS
         JtWg==
X-Gm-Message-State: AGi0PuaO6/Sv9pava72O6JtmN205QD+dOcmFBWP5pHzAOb7ywFkp9hcJ
        DDwt6L/Gf4D+e8Gg84c2Wu8=
X-Google-Smtp-Source: APiQypK/B5K8y7JgEhKcVDEOrPNxlJJc4byxTjtw7DCeF2DtEgjE3cKrFMweNgL+nbTbz2mWMkfPrQ==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr600264pjp.124.1585611143430;
        Mon, 30 Mar 2020 16:32:23 -0700 (PDT)
Received: from OptiPlexFedora ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id v42sm10510446pgn.6.2020.03.30.16.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:32:22 -0700 (PDT)
Message-ID: <098d00e455dbc4ad5500d797b62d472160d065a5.camel@gmail.com>
Subject: Re: [PATCH v7] staging: vt6656: add error code handling to unused
 variable
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Mar 2020 16:32:21 -0700
In-Reply-To: <20200331004213.1c319d94@elisabeth>
References: <20200330223718.33885-1-jbwyatt4@gmail.com>
         <20200331004213.1c319d94@elisabeth>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 00:42 +0200, Stefano Brivio wrote:
> On Mon, 30 Mar 2020 15:37:18 -0700
> "John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:
> 
> > Add error code handling to unused 'ret' variable that was never
> > used.
> > Return an error code from functions called within
> > vnt_radio_power_on.
> > 
> > Issue reported by coccinelle (coccicheck).
> > 
> > Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> > Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > ---
> > v7: Move an if check.
> >     Suggested by Stefano Brivio <sbrivio@redhat.com>
> > 
> > v6: Forgot to add all the v5 code to commit.
> > 
> > v5: Remove Suggested-by: Julia Lawall above seperator line.
> >     Remove break; statement in switch block.
> >     break; removal checked by both gcc compile and checkpatch.
> >     Suggested by Stefano Brivio <sbrivio@redhat.com>
> > 
> > v4: Move Suggested-by: Julia Lawall above seperator line.
> >     Add Reviewed-by tag as requested by Quentin Deslandes.
> > 
> > v3: Forgot to add v2 code changes to commit.
> > 
> > v2: Replace goto statements with return.
> >     Remove last if check because it was unneeded.
> >     Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > 
> >  drivers/staging/vt6656/card.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6656/card.c
> > b/drivers/staging/vt6656/card.c
> > index dc3ab10eb630..df12c73097e0 100644
> > --- a/drivers/staging/vt6656/card.c
> > +++ b/drivers/staging/vt6656/card.c
> > @@ -723,9 +723,13 @@ int vnt_radio_power_on(struct vnt_private
> > *priv)
> >  {
> >  	int ret = 0;
> >  
> > -	vnt_exit_deep_sleep(priv);
> > +	ret = vnt_exit_deep_sleep(priv);
> > +	if (ret)
> > +		return ret;
> >  
> > -	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
> > +	ret = vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
> > +	if (ret)
> > +		return ret;
> >  
> >  	switch (priv->rf_type) {
> >  	case RF_AL2230:
> > @@ -734,14 +738,14 @@ int vnt_radio_power_on(struct vnt_private
> > *priv)
> >  	case RF_VT3226:
> >  	case RF_VT3226D0:
> >  	case RF_VT3342A0:
> > -		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> > -				    (SOFTPWRCTL_SWPE2 |
> > SOFTPWRCTL_SWPE3));
> > -		break;
> > +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> > +					  (SOFTPWRCTL_SWPE2 | 
> > +					  SOFTPWRCTL_SWPE3));
> 
> Grrr, sorry, almost there, I didn't notice this: SOFTPWRCTL_SWPE3
> needs
> to be aligned *after* the open (useless) parenthesis:
> 
> 					  (SOFTPWRCTL_SWPE2 | 
> 					   SOFTPWRCTL_SWPE3));
> 
> because it's another operand of the | operation surrounded by ().
> Doesn't checkpatch warn?
> 
> The rest looks good to me.
> 

I had to switch from a VM to native and forget to put the git hook in
this repo clone.

Still, after I did, checkpatch complained about trailing white space
after SOFTPWRCTL_SWPE2 |, but not the alignment issue. Fixing the
alignment issue produced no warnings either. :(

