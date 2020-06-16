Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304FE207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dUQr4L49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFPWeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFPWeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:34:24 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE08C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:34:24 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so36068qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZmNYWaeeFv3Dc6ixQjxLv5HuZewlv2Zg/Sr+cvRX4hE=;
        b=dUQr4L49bnG3TuO9sz7aMFKYmqT3jGcXug9D9Wz7YNyvjOUwLYpuAGD9Mh3newVIQT
         vmrteic9VcFxcfGU8whoIXVqjQ6N6+uhZ93vQGklZiJa87U4gaU550pTpETcdOjkU48v
         f5DWiZNxQxTDblR1EtgQZz2INcQvf2zQAeQAiUnWwSghBr0giZsBXwYLZcxy+dNyYo7j
         Rvo6xjVR8Vk+ze54yxhJPip3EU6WuqrgnDILtr8qnNbIebPDD8XzwSBo3VxlQ59wCwq/
         uw6aV9Wa60yECrEYI1QfQgb6iqskMa+hNsjjY1IMSnZOTr3wP0y7q6qKUVvWfz6/PxSY
         yETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZmNYWaeeFv3Dc6ixQjxLv5HuZewlv2Zg/Sr+cvRX4hE=;
        b=ZZFQYwMajfzWnm74xQmeu/qaE+Gz4e5g7+mmP2X9vtDareJD4Dogn4Vs09FkrmMFZp
         IpFkpdzsQ0lvVakOMpTr1cnxbqScNYMfSEhUGH4eiVcH7q/7/huLkimmtAl1OIyZokH3
         m9VI2PhfTZ1OuqxS2GRDK5T6VD61sovJATQ0evxI6+QgnTFiEfcb0t6LLId3aYyN2mRi
         9uCorkUDrINhx6kJ9yADhjPkSbRHu3vdZoKkN2qzYsWJmwo+vIGFgl/QTMWjv5DaghZO
         51dSB4IHsmTa+VHPQEDENyW5hYDuSL1UwR5FLIyd7VrahldS802Qz5C+k7213wliuYaE
         Q+JA==
X-Gm-Message-State: AOAM530Lxe4gom897eHpoExtymU5+MmJVbXrtXkqOByX6vRhqAWiZrV7
        aLYBmuRP/fJTMnTlUhnGRVAUZA==
X-Google-Smtp-Source: ABdhPJxHUzrw+EKluDSIJqczlcC1I9RUtmPTLvr08wFp1xZ9mBU2/yPKIK9sNsejd/aP9pjgWdnS5w==
X-Received: by 2002:aed:3f17:: with SMTP id p23mr23854259qtf.346.1592346863537;
        Tue, 16 Jun 2020 15:34:23 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a191sm15221083qkc.66.2020.06.16.15.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 15:34:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] vfio/pci: Clear error and request eventfd ctx after releasing
Date:   Tue, 16 Jun 2020 18:34:22 -0400
Message-Id: <5F40A3A0-1C05-4411-B353-3D4F2E488EE7@lca.pw>
References: <159234276956.31057.6902954364435481688.stgit@gimli.home>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        cohuck@redhat.com, dwagner@suse.de
In-Reply-To: <159234276956.31057.6902954364435481688.stgit@gimli.home>
To:     Alex Williamson <alex.williamson@redhat.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2020, at 5:26 PM, Alex Williamson <alex.williamson@redhat.com> w=
rote:
>=20
> The next use of the device will generate an underflow from the
> stale reference.

Thanks Alex for taking care of this. I suppose my tests were too basic and n=
ever able to catch this underflow in the first place.=
