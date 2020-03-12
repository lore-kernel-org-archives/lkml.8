Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A161C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F869206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584032423;
	bh=r+GtdBn176scwRfz/UATAuqjFTrmObBqykEXc3HcwxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x70rs77A4lv20+w97QfVrm8x9cLNdlH20uNE1X4bGbPgGp5Nb0So9LaJzF04QdyJA
	 QIzRR9GJakVMgqhBnSPlQMJO3P+KDZSOOCz43C9r+zN4K8tTyoXeBeJUneVmsimtFl
	 Sw4WfIETkxnZG0Zsj2xqd/4rbXQwVio6sYRzDJVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCLRAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:00:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42618 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgCLRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:00:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id w17so3922539oic.9;
        Thu, 12 Mar 2020 10:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f0gWE+1m+Ql/v/rWEfu8TjQTj2WuKMi1DQBbx7/F2n4=;
        b=UTFcsx04sePY7WuhwCi3ppQ/lk+QlInV6HyvMh98Zok05PYCiCjNkBoxC3Xo5jxWhh
         Kp6HbFKNrUYOuu2u07QR47SGXCs/aWE+EY1VDxGbCChLi9JTsVO9NU4Jw2ZmcuWJByZn
         Tzs7jnJOSc5QVAIkKX3/R2GtTnVN8WEHO6u3ePhSIqZUZAgncBn1/hCxyrnahaLtJ10V
         dGwFym+gjZwg/JORMRx7QCpkdW5XWChqWt5PwGqvbnz4mi/T1+uGMLj0U3d1sBhguPN8
         3dVzmycbMYmJ/jiGcyOYCCrK0pOrsmJmxlawSLJA9yf2bzOrfAVNLMai1O/WXnBWNJyH
         XxJg==
X-Gm-Message-State: ANhLgQ0uysHGNu1MMaHxXLRJ0eo5CPERQasfsBvkHs471yYBqmFs9Gg9
        JloQLIg2Q6ixlcVg+dVsxq1GrJM=
X-Google-Smtp-Source: ADFU+vsdyR0B1ifapCwJqxa12n/SOqKOgvumt9yTwt5f9bEeJl0JqLXmhvj1v+fFYTFzp6ai6Hlo8A==
X-Received: by 2002:a54:4f81:: with SMTP id g1mr298477oiy.113.1584032421031;
        Thu, 12 Mar 2020 10:00:21 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g39sm5195633otb.26.2020.03.12.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:00:19 -0700 (PDT)
Received: (nullmailer pid 25940 invoked by uid 1000);
        Thu, 12 Mar 2020 17:00:18 -0000
Date:   Thu, 12 Mar 2020 12:00:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/4] dt-bindings: arm: cpus: Add kryo280 compatible
Message-ID: <20200312170018.GA25797@bogus>
References: <cover.1583445235.git.amit.kucheria@linaro.org>
 <6db6e3412e82fdbaf81a2554f176402a8a718bf6.1583445235.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db6e3412e82fdbaf81a2554f176402a8a718bf6.1583445235.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 03:30:13 +0530, Amit Kucheria wrote:
> Kryo280 is found in msm8998, so add it to the list of cpu compatibles.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
