Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF98C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8365E2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/TEF7aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgFIP0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgFIP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:26:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DBC05BD1E;
        Tue,  9 Jun 2020 08:26:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so10434168pgo.9;
        Tue, 09 Jun 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1K8sHcdXpjGKgr+77VdsdCZesRB4PdV8M1C3oEj3EnQ=;
        b=P/TEF7aNarddaQFetGCGJZLD2+MyTqV4fT79+cJ8t0B3IEVLhh7nKcDtCsrUfeX8Db
         zJiY5zKKgTUYl0y5bOBw8b+uXC5Zh+IfgsZD6BN7lpUX7Zi8tOxT7R50u/0tKNu+9zCw
         a9udRVnJhGw2dQ/RJnmjuM/kQp23E6JsTT7zdSpXZ69nZbfd95IllHtpd+zEKHIWlJR8
         hrjKCn8ekVNsUzebAxVGh4mA0d86bjhY6puqwMJDqTxj9BQvhPLZdfekNUtScUrIetCo
         DJKdoXH2vuWFrp/wsx31FmalCiVIjq3MjqHdMa+TCosyXXD3aWNbdAxK76sL4yRCVIOF
         1Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1K8sHcdXpjGKgr+77VdsdCZesRB4PdV8M1C3oEj3EnQ=;
        b=KPlE3bkB9Hvb8O3O0oK/Zs5tqC9Xbw3qznWH7Xm12BBjWF57RN1LEe5np6+vsLLFM3
         C1vt1ehhVCN49QXvA4nrlZ5+k7HDgXZMhIvqs0yKBpyEFnfXHvNIYOJraOTzw1PSy5Ge
         4LqAlTTHnIFm6dW8i0/+wx+BXo7sbhtX1LLKOJi8bwb2629fkOb0/bjRMtD8BGJ4XUbg
         G3a8/fP8nNWweCUR6H99x41UVp5H1Q2mAJzXVSA9Xch408oF+ue+c+Y7DvG2PSy/ob+L
         B0YVpqX7to7k9GgMMZZz3OiXozUlnkhlIWRaGne3245aRgbk2YojLVrJEM4MLJGdWRsN
         /GZw==
X-Gm-Message-State: AOAM532j4luEgYS6QSjsRnjzJZwqVlRiqO5byeAK2mI5nb8ITyF6mli9
        NGNVtJWh76CyGKhc9D3nJ9o=
X-Google-Smtp-Source: ABdhPJwBOJKozhohl5aBI+nYCONer+CHeapbzC/Y9xaA7btNB5oPiCLPbKzm0Q50DpdY6Ml9tBw0nw==
X-Received: by 2002:a62:fc92:: with SMTP id e140mr13037081pfh.33.1591716400545;
        Tue, 09 Jun 2020 08:26:40 -0700 (PDT)
Received: from cnn ([2409:4072:6412:6b70:cd72:839f:5826:c552])
        by smtp.gmail.com with ESMTPSA id y9sm3116403pjy.56.2020.06.09.08.26.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 08:26:39 -0700 (PDT)
Date:   Tue, 9 Jun 2020 20:56:28 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: Re: [PATCH v3] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200609152628.GB8833@cnn>
References: <20200608104349.GA10918@cnn>
 <23597b7b-de89-2911-092e-f3e1ad4884f5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23597b7b-de89-2911-092e-f3e1ad4884f5@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:49:45AM -0700, Guenter Roeck wrote:
> On 6/8/20 3:43 AM, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > v3:
> > ----
> > fix invalid signed-off.
> > removed checkpath warnings.
> > write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > 
> > v2:
> > ----
> > add Signed-off-by.
> > removed ADM1278_TEMP1_EN check.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> > ---
> >  drivers/hwmon/pmbus/adm1275.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 5caa37fb..4782e31 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
> >  		tindex = 3;
> >  
> >  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> > +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  
> > -		/* Enable VOUT if not enabled (it is disabled by default) */
> > +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> >  		if (!(config & ADM1278_VOUT_EN)) {
> 
> This if statement needs to be
> 		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN)
>
          Hi Guenter,

             The below warning shown by checkpatch after changes,

                  WARNING: line over 80 characters
                   #38: FILE: drivers/hwmon/pmbus/adm1275.c:672:
                   + if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
 
                   total: 0 errors, 1 warnings, 24 lines checked

              I didn't see any if() condition made as two line in the driver . Is this acceptable warning ?

         Thanks
         Mani.E
> > -			config |= ADM1278_VOUT_EN;
> > +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
> >  			ret = i2c_smbus_write_byte_data(client,
> >  							ADM1275_PMON_CONFIG,
> >  							config);
> > @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
> >  			}
> >  		}
> >  
> > -		if (config & ADM1278_TEMP1_EN)
> > -			info->func[0] |=
> > -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  		if (config & ADM1278_VIN_EN)
> >  			info->func[0] |= PMBUS_HAVE_VIN;
> >  		break;
> > 
> 
