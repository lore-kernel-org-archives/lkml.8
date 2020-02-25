Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED6C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF132176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MVwL4tMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgBYSVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:21:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43544 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731517AbgBYSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:21:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so7257566pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=iC5nzqy2saMeKutgvDrEBEpuv4q4qMVR1i8BRvTShFQ=;
        b=MVwL4tMZMEEl2E6apD+vt9gHqTB4aVqv4Q/HjRlSH7fMKmhannrm5E9vIkZWY2DoaP
         8syBXB8r64JQsGc1kp+v2kTU+8tHIDDpkRr9Le1VGRdqO2al35oYvUIZKsxK5jtZrfNQ
         Kogo6PvroMVJQlEheMKrYR5XgJERai0cYo4QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=iC5nzqy2saMeKutgvDrEBEpuv4q4qMVR1i8BRvTShFQ=;
        b=QBKgDDpwYWb/swrgLQrTXZLdgs6gFRENkR1i8k0wQFwjeiMCzaWOcWOrA2xNNYFkjE
         l9BvAfZb3xVgUe3W6nkxiKqsGVGu6AdS3grnW6uPrHKUvIObQLKYlYNeRwk5lQKHKJON
         PeAuzBxymzR8IVxP3FxC6RcbQhv7ateUAv++vhflxOS3qb8C/EO0ojE4LIZLdDWdgNCP
         KD7Hgm8trQjCuMPhFzzPXP6gM2WYbvXemUt5D5cD3mpkwDH5EY7HoHL9v/tEIAHXVnQU
         bRuaKsIC+vV+vYjpVXRelgeky8bpcW5AzBc13+cOdWxnRFd9X5vN+Vqzd1bgjj2qHcdD
         dX6A==
X-Gm-Message-State: APjAAAXgY4heAGiJj6g11mzfljRRfQVAYYQ0NjEI59Jmh9Ylmmx+aDi2
        j/+LeAL+RR4YYqsBSXbDlRON/Q==
X-Google-Smtp-Source: APXvYqxRFmacFI+CAN2B515JEZN59wcYjLYX/Z/txp5nfpEfz9dqhyREK3lF14hQ/tQEQsNO5Vg7Bw==
X-Received: by 2002:a63:5124:: with SMTP id f36mr20811504pgb.288.1582654872451;
        Tue, 25 Feb 2020 10:21:12 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id fz21sm4057444pjb.15.2020.02.25.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:21:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581932212-19469-3-git-send-email-akashast@codeaurora.org>
References: <1581932212-19469-1-git-send-email-akashast@codeaurora.org> <1581932212-19469-3-git-send-email-akashast@codeaurora.org>
Subject: Re: [PATCH V4 2/3] dt-bindings: geni-se: Add interconnect binding for GENI QUP
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>, agross@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Date:   Tue, 25 Feb 2020 10:21:11 -0800
Message-ID: <158265487123.177367.16475123402427047498@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akash Asthana (2020-02-17 01:36:51)
> Add documentation for the interconnect and interconnect-names properties
> for the GENI QUP.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
