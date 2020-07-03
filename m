Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CDDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3202088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBIV0nF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGCHT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCHT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:19:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BEC08C5C1;
        Fri,  3 Jul 2020 00:19:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so28699458eje.7;
        Fri, 03 Jul 2020 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTNbUcVOBR4mzYX6GukpYLcNIfkE5YAlOSmlvHsQjmk=;
        b=eBIV0nF5Wn4ntaXCZURfhCZXy1pys/gML2mL1vXiX316K0MT8UuszfbMQktr8ZVnYh
         WirL6cwVz3i69lFx4KVl8sqEbGW7yTdzi9YpCBLzUBo4ua2Hz3BkS8ageqGYuTyPSx2V
         2mwCZ8t7lAUfKJe308U2SsgPX9q70nXDe/KKa2uk1968/7ExK1nYDy00EEAz/l/Zvweq
         H1RpwvLVT/dxCazfeubo2xO2AAJ6PqkQUnRGIS/sGWA/EwWDn29fgGj1zTEGp5AiYf4g
         NXkScyqkuGeeEYu65qE5afFxA0NNRoyrvEV5BACfWZ/f9bvxmwZ3rGbK0T64Kb67iD2U
         IwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTNbUcVOBR4mzYX6GukpYLcNIfkE5YAlOSmlvHsQjmk=;
        b=KZNZfm4LI0i4C515T8yTAJK5wOudKHsERQYIKr6gDMlmiAUapVN3Yhrbok411yHlKC
         ebuyTus16SzskjI7m4KFT5YoK37t4PB2v0GXxpUwEPYEnps5N0Qz4p/ld9mdi+QX15V5
         9VIv8ceqK3IxQ/TS8MtJQG9laVYSTbym8vA6zR9JnysF/NpfDRT7mE3gBtOWoVYlTXvw
         yPN0xMfpHTMdkDCLam6TFkjuskWthCv58phpe/nEQtfH6FEFYJa8Ms5emDOVLlU3hhhy
         njhfb0bRq3k2m/OP/BqIUD8FZaotxQ8agvjX2pq3z+V6/624iRLym5oMCwrlMk74ZaZf
         dsNA==
X-Gm-Message-State: AOAM531Z0f5JSnxdLvmYxj4q2+OsIJc3ckbL8QxxrAIKmfgHcGZUoKu3
        7YiYLLqETNdP22IrQvrtkrj23ciGhuaGYXtJo4Q=
X-Google-Smtp-Source: ABdhPJwOa6rpxZtmMTs3fINNaTmpGwTalX9aqSoKgGXy8FX+/A9tTTAxmikOkhwX9G4SJjVj5BmmZte0slNk0lhG0AE=
X-Received: by 2002:a17:906:1414:: with SMTP id p20mr30312127ejc.247.1593760764917;
 Fri, 03 Jul 2020 00:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-2-git-send-email-amittomer25@gmail.com> <20200702210014.GA1685248@bogus>
In-Reply-To: <20200702210014.GA1685248@bogus>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Fri, 3 Jul 2020 12:48:48 +0530
Message-ID: <CABHD4K8=8+fFu=ZjQHEgR44x+QsvLZ+LW7w=XKH7O4oXu+QY4A@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: dmaengine: convert Actions Semi Owl
 SoCs bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Andre Przywara <andre.przywara@arm.com>,
        cristian.ciocaltea@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.

I wasn't able to reproduce it, even after updating the dt-schema.
Kindly have a look at logs:

https://pastebin.ubuntu.com/p/xTBNNyBdFv/

Thanks,
-Amit
