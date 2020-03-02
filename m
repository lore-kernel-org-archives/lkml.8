Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6D1246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583135400;
	bh=ONNo5czmh6fu5j0BUfw9CMOMf+tPmThhb62/x1pFQcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v7r5MzIY86I/850qUac/EFmIYkHiypLGaOgLXqPwg5IRPQiXHMumfYJVB07p0SBGE
	 lZA/8QEYAmn3arRBOsWvfan8Q1yEJAS4BNq2blBhnbW+jGkFB4n00IKKhB5COvT/YO
	 afmsLChSurbn17mNcj8Q3Y3yzPkmDF0s3FdcE0Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCBHt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:49:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=0Gx1JYZhfx2m87lYF6sjqKW0wz1nAkV9fNxlNiWemtg=; b=DUv3pXp/WnZAz6/NloRdVJoHy3
        mZMQveVL2VS0z5P1D/PcDICmKLczfNXGCBGpl+9Kv3OgtSCpT3W7eUlAW1vwHjfFSheUJRhgjHIY+
        lnXXHN2u04NC3PfDngbIOFXjg6M74Jwez8yXq1CXhCeHRVdhvNoPPlKZrxyvXUtZSe9DcwImDy1rG
        H0AMXKKNNCDV4WOFOWqyaJZ+5MGQCCi4NIHTyH0vdg17cMs6LTIdVGQUNetCHS1edaSWnjfUQ6n6c
        uzVkHJfRooFf+sHodHXWKZ9FPze1bxToD4fZzHw58Bt69UAlXLebJRthTLZZBWQMSc+2ehxaoTgUd
        yUxSCQmw==;
Received: from ip5f5ad4e9.dynamic.kabel-deutschland.de ([95.90.212.233] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8fpt-0003Te-42; Mon, 02 Mar 2020 07:49:57 +0000
Date:   Mon, 2 Mar 2020 08:49:50 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andy Whitcroft <apw@canonical.com>, devicetree@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Joe Perches <joe@perches.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 00/12] Convert some DT documentation files to ReST
Message-ID: <20200302084950.589fe0b6@coco.lan>
In-Reply-To: <cover.1583134242.git.mchehab+samsung@kernel.org>
References: <cover.1583134242.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon,  2 Mar 2020 08:37:55 +0100
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

Please ignore this patch series. Something got wrong with my settings. It
ended getting a wrong "From" e-mail address from my previous employer.

I should be resending it after fixing the issue.




> While most of the devicetree stuff has its own format (with is now being
> converted to YAML format), some documents there are actually
> describing the DT concepts and how to contribute to it.
> 
> IMHO, those documents would fit perfectly as part of the documentation
> body, as part of the firmare documents set.
> 
> This patch series manually converts some DT documents that, on my
> opinion, would belong to it.
> 
> If you want to see how this would show at the documentation body,
> a sneak peak of this series (together with the other pending
> doc patches from me) is available at:
> 
> 	https://www.infradead.org/~mchehab/kernel_docs/devicetree/index.html
> 
> Mauro Carvalho Chehab (12):
>   docs: dt: add an index.rst file for devicetree
>   docs: dt: convert usage-model.txt to ReST
>   docs: dt: usage_model.rst: fix link for DT usage
>   docs: dt: convert booting-without-of.txt to ReST format
>   docs: dt: convert changesets to ReST
>   docs: dt: convert dynamic-resolution-notes.txt to ReST
>   docs: dt: convert of_unittest.txt to ReST
>   docs: dt: convert overlay-notes.txt to ReST format
>   docs: dt: minor adjustments at writing-schema.rst
>   docs: dt: convert ABI.txt to ReST format
>   docs: dt: convert submitting-patches.txt to ReST format
>   docs: dt: convert writing-bindings.txt to ReST
> 
>  Documentation/arm/booting.rst                 |   2 +-
>  Documentation/arm/microchip.rst               |   2 +-
>  .../devicetree/bindings/{ABI.txt => ABI.rst}  |   5 +-
>  .../devicetree/bindings/arm/amlogic.yaml      |   2 +-
>  .../devicetree/bindings/arm/syna.txt          |   2 +-
>  Documentation/devicetree/bindings/index.rst   |  12 +
>  ...ing-patches.txt => submitting-patches.rst} |  12 +-
>  ...ting-bindings.txt => writing-bindings.rst} |   9 +-
>  ...-without-of.txt => booting-without-of.rst} | 299 ++++++++++--------
>  .../{changesets.txt => changesets.rst}        |  24 +-
>  ...notes.txt => dynamic-resolution-notes.rst} |   5 +-
>  Documentation/devicetree/index.rst            |  18 ++
>  .../{of_unittest.txt => of_unittest.rst}      | 186 +++++------
>  .../{overlay-notes.txt => overlay-notes.rst}  | 143 +++++----
>  .../{usage-model.txt => usage-model.rst}      |  35 +-
>  Documentation/devicetree/writing-schema.rst   |   9 +-
>  Documentation/index.rst                       |   3 +
>  Documentation/process/submitting-patches.rst  |   2 +-
>  .../it_IT/process/submitting-patches.rst      |   2 +-
>  Documentation/translations/zh_CN/arm/Booting  |   2 +-
>  MAINTAINERS                                   |   4 +-
>  include/linux/mfd/core.h                      |   2 +-
>  scripts/checkpatch.pl                         |   2 +-
>  23 files changed, 446 insertions(+), 336 deletions(-)
>  rename Documentation/devicetree/bindings/{ABI.txt => ABI.rst} (94%)
>  create mode 100644 Documentation/devicetree/bindings/index.rst
>  rename Documentation/devicetree/bindings/{submitting-patches.txt => submitting-patches.rst} (92%)
>  rename Documentation/devicetree/bindings/{writing-bindings.txt => writing-bindings.rst} (89%)
>  rename Documentation/devicetree/{booting-without-of.txt => booting-without-of.rst} (90%)
>  rename Documentation/devicetree/{changesets.txt => changesets.rst} (59%)
>  rename Documentation/devicetree/{dynamic-resolution-notes.txt => dynamic-resolution-notes.rst} (90%)
>  create mode 100644 Documentation/devicetree/index.rst
>  rename Documentation/devicetree/{of_unittest.txt => of_unittest.rst} (54%)
>  rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)
>  rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)
> 


Thanks,
Mauro
