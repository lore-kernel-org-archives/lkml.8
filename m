Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A2A2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwPsH2xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgGHH2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbgGHH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:28:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0FC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:28:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so36451738wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zl79XYG9RpYOPnp+QVXRdAzYxd6Okp4Q5wCmn7g7MKA=;
        b=AwPsH2xHht4G+BLnA0M6iX+MrsxZJ1Kijghrowztd1bb8KSXFNAHeUaFNcoLZbmRa6
         OFqv49mKAbqonum0vhxSaEUheyYwrJgnGhncgDPaQMC0JM1hpFAjW8UmFSCAFBZORlkp
         H3Dk7LV39V6mByiGm+G24cxG6lzpKcNDooMym/okLE9Nw3J8vw5l8f2oS6ZMgegp2SYH
         ImxEH7zJHfPwy/2lpWpkHFN3LWv7mLTqjVmQ+OVV44RTh1JHnuxFi+NWC+DZs+lWMXJJ
         ZzhyRzEEjEqfzNyfxMxzvJWUtn9z3IlR8Um2lEFNqHW/f0GV2U2nNjjxQrYWwKkyeyIq
         rfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zl79XYG9RpYOPnp+QVXRdAzYxd6Okp4Q5wCmn7g7MKA=;
        b=FuOOuh21wxq7XNzziJ8P3wkLlMZradQ7aKU7umZFl8nWMK0IrElaYA9SRqs+qVEw7w
         aBz4lUWMlKtjRhVBd2YSkX3bU50IbF0A31SLE5v2hAx0ekVaNsTzph09hB0ikiIJ7+3l
         4Ifbboa7ht0KDLU0/G1QJKLKCXvd+FzY1RBjgkQfSmauT9I8QCHzBSsAVnLz7vsmj3YU
         U7C9IeOg8uEwf9ENpwIpOJIrRpB86Rhp0HZLrujyTGsOH3muhGI7I/pnQBC7aJhCh7WE
         qBwT6Gg3P0nQKO1g7UBJepnA0D6Mgoh3/G9q2tWTTp8uPzCT3Pyo4lR2h/bJFmEgfeUY
         k1Wg==
X-Gm-Message-State: AOAM533LoRYCVqAM5H/nn6dKsjpfo/fZsxf9X0c9dOrjgl+IG5KQ9Jo8
        Kt+d1k2xLzd9VhbDnqOaNdXnYRpotow=
X-Google-Smtp-Source: ABdhPJxXJm9MquwLLudzjpDO/k3N8W36ftniU9l86lvBSq7ameDk2knhL/eF+gIV17Cqkrz0C37PaA==
X-Received: by 2002:a5d:4002:: with SMTP id n2mr60579055wrp.255.1594193331795;
        Wed, 08 Jul 2020 00:28:51 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id n17sm4107493wrs.2.2020.07.08.00.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:28:51 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:28:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix a bunch SCSI related W=1 warnings
Message-ID: <20200708072849.GM3500@dell>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
 <159418828150.5152.12521251265216774568.b4-ty@oracle.com>
 <20200708065100.GK3500@dell>
 <yq1mu4azea8.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1mu4azea8.fsf@ca-mkp.ca.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Martin K. Petersen wrote:

> 
> Lee,
> 
> > Out of interest, do you know of any other efforts to fix W=1 warnings
> > in SCSI?
> 
> I am not.
> 
> I try to encourage that all new patches get compiled with C=1/W=1. If I
> could, I would strictly enforce this. However, there is just too much
> vintage code around at this point. And even some of the most actively
> developed "contemporary" drivers suffer from a large amount of sparse
> warnings.

Exactly.  This is what spurred me on in the first place.  I really
wanted to build my own subsytems with W=1, but due to the very many
spurious build warnings I was forced to avoid them.  Once I fixed my
own, I thought "why not fix others", and here we are.

Backlight, MFD, PWM, USB, Misc, Regulator, GPIO, ASoC and MMC are all
clean.  Now it's SCSI's turn.

> warnings. Would love to see things cleaned up.

Great.  Watch this space.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
