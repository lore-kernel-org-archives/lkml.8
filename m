Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0822C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9428620771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYDZvqgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgC3VrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:47:21 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50198 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgC3VrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:47:21 -0400
Received: by mail-pj1-f66.google.com with SMTP id v13so192029pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=en1IQMIc1TSs5b2IKh+4WaDfSDdVceKaSf3PzbyQVGk=;
        b=QYDZvqgySdojAuttsMOyUaM59cNDeHhD6pD5L2vS9lo2vYP742n43Ujw1Tg+IkNjSW
         pRH+VgRK6qCCyDXUQZfye0Snj/Eno6WQWXm8dbkZY9LhTvj02sxEljw63gM0iXhtxi+l
         C8Shy3SisPiKds6rbsVtHoEV87N7zXc6nWlmIW7Snyj2FpD1wLdSxn0mmi2ljNGj67ZX
         MloEciRVc7nOmgCrZMBlXk4uHqIi4qf3GUCKDCOSdxHWDUsM71CBa8XKycF+QN7mwCS8
         KiZaxuR4dT10NUHZD1KeUELRQdKmStLqECScfOAkEu6mXbBWY5Ad+IEmJdSP81M7RrW5
         xspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=en1IQMIc1TSs5b2IKh+4WaDfSDdVceKaSf3PzbyQVGk=;
        b=ipqO49F4HFkyCXy6HjSdSx9kywnLPPWP7WNqlgI6/qXgCx6rKfFCq+Zjz+7uInvraA
         rM1XhE+ZpFKzsDPXfmVN7jbe0d6q13EW/iDMyw/Q72pKwlTPFFPV+Mqh7uJhpHffUO8o
         nMIbeiglNHBhIoIh5Fg5wVqCb/3G2t2VgMunFq+J/DLxcjYeCVYV1tevg4mWVO8bW9Rj
         t1vv1awbTGWl8mYouS2KcShseYalnL8HKJ983bNvJJcmj3+IPlwefmhAVcTFiITt3Dzq
         0a1+ztfl9BtuaCS0hBVVi7q4cHa4pWW76jV4w733lK3BPR7ErDnfrRA+B+T3ERHY3yCK
         Wmmg==
X-Gm-Message-State: AGi0PubLh3vIyWGgvWezwDEKhvnASj6PlGOnPZJw3ehkClgh3CYaLcMo
        b75XQINx4Fd0g4kRwMlhGAY=
X-Google-Smtp-Source: APiQypKO9FNhqZtpIqoCfW/g91iF4UaQSHBTM3F8V9VJxyYM7VjGkDR2yG+cZqDTO++HN2wJHdfClQ==
X-Received: by 2002:a17:90b:8c4:: with SMTP id ds4mr212979pjb.44.1585604840076;
        Mon, 30 Mar 2020 14:47:20 -0700 (PDT)
Received: from OptiPlexFedora ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id z12sm11387743pfj.144.2020.03.30.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:47:19 -0700 (PDT)
Message-ID: <5d2cda14795500ae6cc862b98907a7210688269f.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v5] staging: vt6656: add error code
 handling to unused variable
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
Date:   Mon, 30 Mar 2020 14:47:18 -0700
In-Reply-To: <20200330230634.3b905158@elisabeth>
References: <20200330184517.33074-1-jbwyatt4@gmail.com>
         <20200330230634.3b905158@elisabeth>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 23:06 +0200, Stefano Brivio wrote:
> On Mon, 30 Mar 2020 11:45:17 -0700
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
> > v5: Remove Suggested-by: Julia Lawall above seperator line.
> >     Remove break; statement in switch block.
> >     break; removal checked by both gcc compile and checkpatch.
> > 
> > [...]
> > 
> > @@ -734,14 +738,15 @@ int vnt_radio_power_on(struct vnt_private
> > *priv)
> >  	case RF_VT3226:
> >  	case RF_VT3226D0:
> >  	case RF_VT3342A0:
> > -		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> > -				    (SOFTPWRCTL_SWPE2 |
> > SOFTPWRCTL_SWPE3));
> > +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> > +					  (SOFTPWRCTL_SWPE2 | 
> > +					  SOFTPWRCTL_SWPE3));
> >  		break;
> >  	}
> > +	if (ret)
> > +		return ret;
> 
> Did you send the wrong version perhaps?
> 

Yes. My apologies. Please see v6.

