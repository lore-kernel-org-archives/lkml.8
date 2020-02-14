Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE3C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B192168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8vKwe4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBNCXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:23:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36798 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNCW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:22:59 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so3277919pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=qux6BbvWAe4p4P/wAZ0A+Tgsqzz5Ke6rXhlE3TNAZMo=;
        b=P8vKwe4xSe7pQWTLvaOXQ2q5lhGX0j40d4RSrt6o9LpHnxqiPRbA/zq73dX2t/4r/l
         Y+036nBLxx3FvWqRaXbp9aqDhnakRgcd6kkLBqsKEQFRYFD/DH97YduK36SuKZEH9rsm
         GoTs3CJ2/bT9pltuH6A81V3OT/M77eN42uY34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=qux6BbvWAe4p4P/wAZ0A+Tgsqzz5Ke6rXhlE3TNAZMo=;
        b=k+4DwyYiF869hodPlB6I1mWCxnTc6evZuiJIRJhsIfUt6bUMrTmdg5dJNJX9n1LPqT
         SngyIyRI5+CArDQnnBtp30n/+F1Oaeu83lat+IPUDlNBAA78naY7HEUax39EDQX9nqmf
         bhzQk4i7mf5rk2THF1b8roOKutppmYSHdYRdcjETuexWvC9IvjlZ9u3cTAOis0CVpA0B
         l5qYjeD2WGWGO6pr3ywpiTCCR10MWX2EeeCw094Dkixlw2ycvN/m/n6FLv3uDlsr+4E1
         kLGqROTVRKkjzohWuenucCuJtsEkU5vPE/zwB2PdXCqcxTxIIDamDGBAicYPMQb2JUuH
         Z7Vg==
X-Gm-Message-State: APjAAAUXwUfY74s1PJHwsQhZYw5TUez46sIsYLEnXPyIqJcwqVOmwiEp
        2RbAvuUqSzfnA9QiKDl7L3YjLw==
X-Google-Smtp-Source: APXvYqyJ/jvq2tN5ADG2mCUonP7BvFYO8jOQOL4ElMrE52UeGn5nCy1bOAxohojLnenru9dUsef8Qg==
X-Received: by 2002:a17:902:c693:: with SMTP id r19mr1018218plx.25.1581646977474;
        Thu, 13 Feb 2020 18:22:57 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cx18sm4052762pjb.26.2020.02.13.18.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:22:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581609364-21824-1-git-send-email-gubbaven@codeaurora.org>
References: <1581609364-21824-1-git-send-email-gubbaven@codeaurora.org>
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Bug fixes while collecting controller memory dump
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, robh@kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, tientzu@chromium.org,
        seanpaul@chromium.org, rjliao@codeaurora.org, yshavit@google.com,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org
Date:   Thu, 13 Feb 2020 18:22:56 -0800
Message-ID: <158164697600.184098.7937205486686028830@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Venkata Lakshmi Narayana Gubba (2020-02-13 07:56:04)
> This patch will fix the below issues
>    1.Fixed race conditions while accessing memory dump state flags.

What sort of race condition?

>    2.Updated with actual context of timer in hci_memdump_timeout()

What does this mean?

>    3.Updated injecting hardware error event if the dumps failed to receiv=
e.
>    4.Once timeout is triggered, stopping the memory dump collections.
>=20
> Possible scenarios while collecting memory dump:
>=20
> Scenario 1:
>=20
> Memdump event from firmware
> Some number of memdump events with seq #
> Hw error event
> Reset
>=20
> Scenario 2:
>=20
> Memdump event from firmware
> Some number of memdump events with seq #
> Timeout schedules hw_error_event if hw error event is not received already
> hw_error_event clears the memdump activity
> reset
>=20
> Scenario 3:
>=20
> hw_error_event sends memdump command to firmware and waits for completion
> Some number of memdump events with seq #
> hw error event
> reset
>=20
> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump =
during SSR")
> Reported-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
[...]
> @@ -1449,6 +1465,23 @@ static void qca_hw_error(struct hci_dev *hdev, u8 =
code)
>                 bt_dev_info(hdev, "waiting for dump to complete");
>                 qca_wait_for_dump_collection(hdev);
>         }
> +
> +       if (qca->memdump_state !=3D QCA_MEMDUMP_COLLECTED) {
> +               bt_dev_err(hu->hdev, "clearing allocated memory due to me=
mdump timeout");
> +               mutex_lock(&qca->hci_memdump_lock);

Why is a mutex needed? Are crashes happening in parallel? It would be
nice if the commit text mentioned why the mutex is added so that the
reader doesn't have to figure it out.

> +               if (qca_memdump)
> +                       memdump_buf =3D qca_memdump->memdump_buf_head;
