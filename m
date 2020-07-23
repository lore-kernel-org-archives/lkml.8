Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C665C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097452065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595538508;
	bh=gUOhmKi3UhX9bxHFI5qN8uuW2CPNvuGTo/nzwnUanrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZdKozAw5nYBze7cXQ2Ub+TUeQfKt7NAcZRcQpQsSTV4mwq7TzBuHz712r7xwY4SZm
	 WnTmk6SuWHqUXcC6Ks8r3z/wP88HfnudQbDzJImTHMaQMMpBjUvBi9tk92jekRf6rc
	 96wWMYBT3JUwFnAXYK7M0SmmLrMEoBd8apDjgdmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGWVI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:08:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34188 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGWVI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:08:26 -0400
Received: by mail-io1-f65.google.com with SMTP id q74so7787516iod.1;
        Thu, 23 Jul 2020 14:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8rFzDJNt24ro4mYAv9D9J2VRgdC5RJdeKmaQUUN0gw=;
        b=R56FPoFSx+6y4SgxkCfNcS1VAslPhB8K6Q2vuswFCNDb8TdsAhDyotM/7v0x0DCNZg
         +fvgXdjLe+8gNEVlSi/YLFexfqpDNRK5/CtwbZgpHR1EzLgLDsddXJ+KXLs5IvAK6o5p
         VapkT19QuWML41hh1e2+Th1HFTJoODA4n1lpYP5pv1pKXnBpfPlyeZbSLiYgC9BKTJlt
         +6ZcgDd5xdcYTYNct2hK/aWAU0n+GfRDKWo/qeiLv2GCIMYWNhJUAeTfh17bAeoieIEM
         iX/ltF3x3yk1JS3ijsBth13Dx9YdUiA0JpNfFkCXBns9mDHGktatLH/tc8NwpFKBBnmn
         tqwQ==
X-Gm-Message-State: AOAM5334u+IoHv5JdU5MXMTaBSnUv5hKCCfYEZ9c8wIIzy8l7lZq4cfo
        JwzDSTNvn55jblywtlnkLg==
X-Google-Smtp-Source: ABdhPJyKXQljQcSpvukJyZtzXdvt+eIkqiNmYHwIia4CwXjQA7bH47vo9Ozj+4DvV3aZ2T782Pw4PQ==
X-Received: by 2002:a6b:5c0a:: with SMTP id z10mr6860424ioh.131.1595538505584;
        Thu, 23 Jul 2020 14:08:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p20sm1591837iod.27.2020.07.23.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:08:25 -0700 (PDT)
Received: (nullmailer pid 861673 invoked by uid 1000);
        Thu, 23 Jul 2020 21:08:24 -0000
Date:   Thu, 23 Jul 2020 15:08:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: Convert olpc,xo1.75-ec to json-schema
Message-ID: <20200723210824.GA861600@bogus>
References: <20200718211244.187938-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718211244.187938-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 23:12:44 +0200, Lubomir Rintel wrote:
> Convert the OLPC XO-1.75 Embedded Controller binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
> Hi,
> 
> please consider enqueueing this patch for 5.9. It is a straightforward
> conversion of the olpc,xo1.75-ec binding doc to YAML.
> 
> It applies on top of v5.8-rc4 (where a fix into olpc,xo1.75-ec.txt
> landed).
> 
> Thanks
> Lubo
> 
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 --------
>  .../bindings/misc/olpc,xo1.75-ec.yaml         | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> 

Applied, thanks!
