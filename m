Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E7C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442FB2076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WhrVOzIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCRWfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:35:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46695 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRWfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:35:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id t13so127223qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhKkOM3b73+SqbFIo7hXR89joO3mVm2xuh2r9R0UJAU=;
        b=WhrVOzIZjfGqMtoJLSU/8B+vpAX0KzmrPOyRaB4p44ABZ1rfa8h22X3W23XhQtZlVe
         EHFXfkIIpM/l63+xuvfsrAx+/Vw/G0YR8aAjcHfmNThjmxBPkRn0z1hKG+F+S8pZQmjz
         hBqrw21HhngX5cnWexV+yppEao+OT6MuIzBuQXfiBbw1/GIW7nMiI7JZ30uPU+yqbnrd
         vsRT926fuCX58mQo6tbDjkA7VrjhyRu+OYElRqlRNbIC7AgFdkoo/bOyfQzQsUCzqYRo
         yPg2GBD24ka+n8MvuwSUBKFed13j6xdXVHfsIg3DfWsMWyoJnfr9zHPEdv2cnEYwMUU+
         Thkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhKkOM3b73+SqbFIo7hXR89joO3mVm2xuh2r9R0UJAU=;
        b=IWaijXNvuqU6jRJqc43R2nQ52BD6j78lSphqVm1E+Vkgygg5nU6/kAWx/cu4wkJCEh
         hN53zt9CG2YNSEcnJpBT8GP5f0dOzC+Iewh2dmoqRS1xOuUHN4Cx8EnN6mJ4ApunS8nc
         nwFIZ7t4Q6blW6ld//TXJg0rBHOQ5+pT2e5zSH7qJ4oIyEjd66T6vowYCWFqvbzHq/xY
         +K5Y8AUMU6MzzDxmERpr4JKLQCsvuj/5WoN/2zAzVqrXIqArtU4JYmcLuNRs5/4w9UTv
         abm+6ufqKwG0eI9VuouJrqtRIFHrcVi2Y6j/lkevvbO1Pm5S09sh+SEFNMegYlUJw8Ej
         TtsA==
X-Gm-Message-State: ANhLgQ0W0HNHiy1gVQZFmkBoBQnhvpNyS0YtaTuvudSpugg9qnSUCIFQ
        uiWoppMppxx1iRshmGmjnTF56v/yomnHzA==
X-Google-Smtp-Source: ADFU+vuIGfOWs5zpaMxj9pIV+cXJGTA7IPUuUJDipiGDUwSNYNmjn9yaBO/yPCkYnT8wT6e0VL8Hrw==
X-Received: by 2002:aed:2be5:: with SMTP id e92mr7243738qtd.374.1584570943737;
        Wed, 18 Mar 2020 15:35:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x5sm145093qti.5.2020.03.18.15.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 15:35:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEhHq-0000C1-LW; Wed, 18 Mar 2020 19:35:42 -0300
Date:   Wed, 18 Mar 2020 19:35:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     George Wilson <gcwilson@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200318223542.GD20941@ziepe.ca>
References: <20200317214600.9561-1-gcwilson@linux.ibm.com>
 <20200318204318.GA48352@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318204318.GA48352@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:43:18PM +0200, Jarkko Sakkinen wrote:
> >  static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
> >  
> >  static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
> > @@ -147,6 +149,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> >  {
> >  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> >  	int rc, sig;
> > +	bool retry = true;
> 
> Cosmetic: would be nice to have inits when possible in reverse
> Christmas tree order i.e.
> 
> 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> 	bool retry = true;
> 	int rc, sig;
> 
> It is way more pleasing for the eye when you have to read the source
> code.

I thought only netdev insisted on that :O

Jason
