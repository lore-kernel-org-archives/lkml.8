Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF0220719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUtCop/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgCZSWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:22:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40298 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgCZSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:22:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id r19so1088649otn.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxL0ioGFfMwjynlJlfLLWjyZe5fDeVy9kFRmHMW+Zn4=;
        b=HUtCop/N6lNjtvAtGQl3Qm5p2bBQhIlBLItjnkXj5ZKpT5PppcECix1JfOr48DRO4N
         iavXL5M/GEeqb3r7Rq1msl0BQpyCkLqK3Ve3pqzIdC6/icFLJOyCL9QRML8kWvfUN11K
         Vkiskx8LkX2OP9kr+Cz/F9EvejTbX1PmtkMqV46iwKlukQuniFRu6D4dWMNtzALmN4UO
         J1LRjHyLjfvSqMiX3w0CJ1TIfV6fo6HEMGexJE7SVUYm2AJB+o+ujQdi1DIL73voh0rn
         xuEeof8e+1XOjoagT1sxjmbw2ll+A+tolU0hhsZx2FK5/sjirw0gamQH41k21r31Ku5p
         uXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxL0ioGFfMwjynlJlfLLWjyZe5fDeVy9kFRmHMW+Zn4=;
        b=Nac8BBLAJMqARiJ6obtfvTLBQ7zPBhgvqCzkt8SuKg602CoWA79P4uL3NBfA+2IBO9
         w9RbudbXA2HPwMnx1qcmHEeg49xloYmKYTpkWREU08/Orcsektv9qEp4sjvrdLqdsK9+
         7DnIFJipnJAn4habuPSwwM/fjB8C/8V7Fj9BD1ZsJaBWAht7VLVpYiq6Q2nw7O4sY5CF
         T4poM49U8urFIGVKDMvImLw4dAe3wnAfw8YdjN5izY08n2C0U1sAdfjbcDnggCVBaz7p
         uRP2Qg7yh/3Y5MgsYPzeJYjEUp9zBkMetpsd6jZafCISB3UIQeaCDbYH3GcYHT5wvMfa
         WCfA==
X-Gm-Message-State: ANhLgQ37LfRKMmZhNNdi9xjhDAMl5SztkHRIvBw6OYLkU2cvQ0k/LjQw
        GWL16WkwG2EA7NEDGtIS6a7aGfqpdgk/ZMbpaudRlVAG
X-Google-Smtp-Source: ADFU+vtksZIIqekjFEA7AN+kJkboACCxTSymovsuMEtWozINteGk0Gs4LbaZXL36DLqPAcNR1Tpr+XMZlCKK2XGsTF0=
X-Received: by 2002:a4a:b507:: with SMTP id r7mr6304216ooo.70.1585246964628;
 Thu, 26 Mar 2020 11:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200326172457.205493-1-saravanak@google.com>
In-Reply-To: <20200326172457.205493-1-saravanak@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 26 Mar 2020 11:22:32 -0700
Message-ID: <CALAqxLV6CQkJXdtBD5vUOvLYCe10sEUPa4RS9PuGB2=e4-80rQ@mail.gmail.com>
Subject: Re: [PATCH v2] slimbus: core: Set fwnode for a device when setting of_node
To:     Saravana Kannan <saravanak@google.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:25 AM Saravana Kannan <saravanak@google.com> wrote:
>
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink feature to work for slimbus devices.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tested-by: John Stultz <john.stultz@linaro.org>

thanks!
-john
