Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B16C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AED2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdj8ICMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEDNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:31:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2903C061A0E;
        Mon,  4 May 2020 06:31:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b10so1071145vsh.1;
        Mon, 04 May 2020 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKVu8p9mULpUJV26UBlO0ZNVdeoAZyl4GvIcj32jLfc=;
        b=Mdj8ICMvEINKyngRw0C56nn/l70As9jUYBHBkF7cB5XPbu+mS0V+QXTSGwZ9vlwKq/
         lkS7FbUhHKFI1QZLjxbDEtVDHihnWopja1AsKIp/YiO6vlZuHplAaKzMuaf5NSWarM2f
         KE6OzrRJue09kKbucJDol8hpl92GUJw5LCudHtr2vwmQhIff8Z7LW3KuKoGvJ/9c8lUU
         DobuZ7uqytasqL9HeMiFXjeogYQTH2QtTtcOfKk05IDThTnqhz0uwt8isZ9nrz4Vg/S7
         1m6i83pXMaNaZW/a0QUdFo3Fo/YLOU2tkt1jq1akV8fUi/jwrnk8jfSWaUZs/RdsCMzo
         yFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKVu8p9mULpUJV26UBlO0ZNVdeoAZyl4GvIcj32jLfc=;
        b=Zn2XbajQ5oftqxqmjQA08UZAfmg4RTReRUFnOF7vP/fjjGfa3UWINluS7k3JCIpjaP
         34nrVara1mzrZnJdPI9+qGcB/OMuLiR8DartFDnUd/BOKZuYXHlmOMhavW5pC4QrZLFt
         3fvqTlTxhVMmqEPGVgx8IV6Gruro1A4PMzXf96LtdAc9nmZ+IevP1r0YjspK/fQDrLlW
         9aQlagMeSeSZwYUlOAYfE9OYI3h0JgxmAsiuycWkeACK52Ep3fACyvKbrHSTEhMJsxvx
         7n5TervmDPX47LGIO2yuglEXqDvaRpVkTeB30U530mmwC1c18VSgSstOGjKi/CDuV21p
         CZ0g==
X-Gm-Message-State: AGi0PuZDLV0lQ0LWCiVieBj41Ee86CqC1vnCYLvXRpcVeEA39w6vI/FV
        t9Zk4VXiIKjEqnEzCg+DTbeFV13vmAJmGQqteYY=
X-Google-Smtp-Source: APiQypJrs2cq7AvRRR2YZKwloVT46aVj/YrXmcbh7EbV/r3x3vAWHo4cobHouut4syrWSDqbQsPB2Tivz++SgHG/97k=
X-Received: by 2002:a67:c482:: with SMTP id d2mr12058478vsk.37.1588599071846;
 Mon, 04 May 2020 06:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200430192746.1866325-1-paul.kocialkowski@bootlin.com> <20200430192746.1866325-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20200430192746.1866325-3-paul.kocialkowski@bootlin.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 4 May 2020 14:28:47 +0100
Message-ID: <CACvgo51mRse3su4exyTqXYJRPPc0VqaX9+tRyKUuBPtm5Q+6XQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm: Add support for the LogiCVC display controller
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Just had a casual quick look for custom KMS properties, since new
drivers made that mistake in the past.
Thanks for not including any o/

I made a couple of trivial suggestions - if you agree, feel free to
keep them as follow-up patches.

On Thu, 30 Apr 2020 at 20:28, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> +int logicvc_of_property_parse_u32(struct device_node *of_node,
> +                                 const char *name, u32 *target)
> +{
> +       struct logicvc_of_property *property;
> +       const char *string;
> +       u32 value;
> +       int ret;
> +
> +       property = logicvc_of_property_lookup(name);
> +       if (!property)
> +               return -EINVAL;
> +
One could have the logicvc_of_properties[] entries indexed with the
logicvc_of_property_parse_{u32,bool} caller, using that instead of the
name string.

Aside: I suspect the array (as most other arrays in this patch) should
be annotated const, correct?


> +       if (property->range[0] || property->range[1])
> +               if (value < property->range[0] || value > property->range[1])
Combine the two ifs?

-Emil
