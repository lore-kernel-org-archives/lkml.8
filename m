Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10474C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCC0207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591821539;
	bh=vVDBawfAIxR+XgFV9N0wVIVrEr9RkqoH4OUGfhUX4TE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uI3tvS+P3yprNgLoMZTaH8LSTqcLzhSCXNkjpsi4byft0BY3qx9OQp2g38+ZF6Lw7
	 phEFLnywmCd4U/SuZPU5ULyD0rX+bjIXOJIATm0K4beUiXjslI9MfZ0EGzvBYGJHpQ
	 mxjmSY/SGuCcovKLXPtekysy2nqnMVMwGyIGJZIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFJUi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgFJUi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:38:57 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB8D207ED;
        Wed, 10 Jun 2020 20:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591821537;
        bh=vVDBawfAIxR+XgFV9N0wVIVrEr9RkqoH4OUGfhUX4TE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obrMb8CFFtynYPduPZU5dw8GK0JLm4lbIpVKlhyxSMP3ZYf9FftY2ArfbXLa5M8HM
         ZQmMAtKKCVEcnbzT6GwUR5vtSc80RJjZIt7aWZm47gkROA+yI/H8IeNS4B2F/fzdyK
         BpLZ3iT/zOih+RgES70kk3kYmmDjFCoV6Q7B43sU=
Received: by mail-oo1-f45.google.com with SMTP id z145so771708ooa.13;
        Wed, 10 Jun 2020 13:38:57 -0700 (PDT)
X-Gm-Message-State: AOAM530X4NK86tlYVVemqxSfJKtg10ovYk445zaRZsdrsGAkYZ/1UAFO
        OOdTBWAjgm4cq6Koy/EEJh9UYzVtCq9/fdwvFg==
X-Google-Smtp-Source: ABdhPJx2fhOu4m4KNgYLDqdqhDoSmIrYDD7miA7JHI17HFjaaea3za14GBOk8BLETs0s+5g2YjldV90dmMWdq6ZaZzg=
X-Received: by 2002:a4a:6156:: with SMTP id u22mr3669189ooe.50.1591821536614;
 Wed, 10 Jun 2020 13:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
 <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com>
 <20200511221755.GA13585@bogus> <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Jun 2020 14:38:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
Message-ID: <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
To:     Ben Levinsky <BLEVINSK@xilinx.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:40 AM Ben Levinsky <BLEVINSK@xilinx.com> wrote:
>
> Hi Rob,
>
> The Xilinx R5 Remoteproc driver has been around for a long time -- admitt=
edly we should have upstreamed it long ago. The driver in the current form =
is using an "classic" remoteproc device tree node as described here.

I would rather not have 2 possible bindings to maintain. If there's
been no rush to upstream this til now, then it can wait longer.

>
> I am working with Stefano to come up with an appropriate System Device Tr=
ee representation but it is not going to be ready right away. Our preferenc=
e would be to upstream the remoteproc node and driver in their current form=
s while system device tree is maturing.

There's obviously going to still need to be some sort of description
of the interface between cores, but this has parts that obviously
conflict with what's getting defined for system DT. The TCMs are the
most obvious. If you can remove (or hardcode in the driver) what
conflicts, then perhaps this can be upstreamed now.

Rob
