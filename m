Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD159C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFABA2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycc1KEIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgC3W0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:26:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38339 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgC3W0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:26:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so7321240plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=s+MoJHMSmcTUpq3uJxnfw8RVUGWalt2lStS+Ah7bIw8=;
        b=Ycc1KEIOagcHVpqjoqTdfsL8SXZV1i++qn05Rgy8VdmDp72xVkhS8K1vnLdiF6MQc0
         LovPWxqrUa8uOtPkhubC5G1/vHnyQgfh1cBs6LjDI96nKCBeQFfiBefGa8f7U2rvOmLp
         ZIwmTYa3aPwoL47kaUKGGZg+NyJqNd38Fn0GTuWgY1G5XevW7LmlR7EuUCI9Szc91BzI
         VS7XbAMruSlBt5pELkjNUuSF6lRdHCsM8oRvhlOUysXOf1FdwrXeJA/6wtvo5LUVNRM0
         2swl6ETvnTFp0mSnOPaXBFG9pN2iewLiDZutUQn/Uuang/YFqkEpUA47goeAmwJTnqR7
         oopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=s+MoJHMSmcTUpq3uJxnfw8RVUGWalt2lStS+Ah7bIw8=;
        b=NRpa1X+msjuTl7cULaItt0QLXvf6GMOuLU3KDj8E+/glCyK0/d35UFY5Tbe1ISH9XL
         QlzjFOAE/7W2sAJlHEDO77Swv8bCmd/eBeCAGRAWSDO1McXbW3idLpSMzp05jNOGNDFj
         23UJBFuvkd1mxxlkm8Xc9INbzTqL6VJzqvnmmMf3DYEnz1KG0S8y24rX+Don4tYh1kAo
         G8tKhuTWqT6AHWMmtafA3yaLe8ovrrTLw7zOUHvXSOijT3SUu5Teu6tWmnRRZKGk+NGj
         r3vh/M/WMdCIn6Gm3ZRDkP+w8q7OB1gIFwvfwCagxAnUec3gh4su5DJkkNzQR++V3zTA
         9u+g==
X-Gm-Message-State: ANhLgQ38cPQPUfqN4mZNznC0M7ke5pKJMk8KTiloowdpjsS+A3+KdivS
        zLiLueA9pdXC3y2AKMd6AmQJZyhNIKYnaw==
X-Google-Smtp-Source: ADFU+vuDe09EskbUbkoynvPaMH4Zoi2aALAdNwdjmmf214C52u2ClsXF+RhYKQAE8Lc6BEXqVVnCkQ==
X-Received: by 2002:a17:902:aa97:: with SMTP id d23mr14477810plr.244.1585607166274;
        Mon, 30 Mar 2020 15:26:06 -0700 (PDT)
Received: from OptiPlexFedora ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id c201sm11015633pfc.73.2020.03.30.15.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:26:05 -0700 (PDT)
Message-ID: <61bb6678d48557895671488357a62680d0ae655f.camel@gmail.com>
Subject: Re: [PATCH v6] staging: vt6656: add error code handling to unused
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
Date:   Mon, 30 Mar 2020 15:26:04 -0700
In-Reply-To: <20200331000143.7c8f98c0@elisabeth>
References: <20200330214613.31078-1-jbwyatt4@gmail.com>
         <20200331000143.7c8f98c0@elisabeth>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 00:01 +0200, Stefano Brivio wrote:
> On Mon, 30 Mar 2020 14:46:13 -0700
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
> > v6: Forgot to add all the v5 code to commit.
> > 
> > v5: Remove Suggested-by: Julia Lawall above seperator line.
> > 	Remove break; statement in switch block.
> > 	break; removal checked by both gcc compile and checkpatch.
> > 	Suggested by Stefano Brivio <sbrivio@redhat.com>
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
> > index dc3ab10eb630..c947e8188384 100644
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
> >  	}
> > +	if (ret)
> > +		return ret;
> 
> Hmm, sorry, I haven't been clear enough I guess.
> 
> This is what you're doing:
> 
> if rf_type is not in that list:
> - set some bits in a register
> - did it fail? return
> - did it fail? return
> ...
> 
> if rf_type is in that list:
> - set some bits in a register
> - did it fail? return
> - set some other bits
> - did it fail? return
> ...
> 
> Now, the "set some other bits" part is already selected depending on
> rf_type. There's no need to check 'ret' otherwise, so you can move
> the
> return just after setting 'ret', in the switch case.
> 

Thank you for pointing that out Stefano. That would be a serious issue
with logic.

Just to be sure. Are you looking for this?

switch (priv->rf_type) {
case RF_AL2230:
case RF_AL2230S:
case RF_AIROHA7230:
case RF_VT3226:
case RF_VT3226D0:
case RF_VT3342A0:
	ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
				  (SOFTPWRCTL_SWPE2 | 
				  SOFTPWRCTL_SWPE3));
	if (ret)
		return ret;
}

> With a check, because you don't want to return if ret == 0.
> 

What do you mean exactly by this?

The new code should only return a 0 at the end of the function with the
vnt_mac_reg_bits_off call.


