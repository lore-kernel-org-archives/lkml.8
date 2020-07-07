Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5004DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB820771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eig7ACSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGGO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:29:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D27C061755;
        Tue,  7 Jul 2020 07:29:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h22so42980634lji.9;
        Tue, 07 Jul 2020 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Or0lYQVNJ3ZFTvEKcGdp6AoYMkJnpUEvesCucB/s/eA=;
        b=Eig7ACSNKBihkxVTkdaoPlJSPR9yhc5A1NgIfryFh+aZ1/OPt2JF7JxQ9qMEyRo0WC
         JBnmuriXLXe07JxKRZmEq3I+j3Fnh9y6bdCe0b9aRUqpfUByxrQe+oAkuXqj7W4BEg1q
         2GIYlJpL/9/DCgnQizPEUSwVzx/a75C27STAid79ScuTBY8VN+wd1Ro6TqLWcnFaOe1e
         TaKd1Ne5LmiEzjkN9EsoMcTpEmouff7AWvIj7wF/TVwlb3n9Hhs6/QCfmLS+zzWB2v+Z
         R+BTbLWr99QWhCTg0PEMIxUSV3x49yVfAVxyg3DylSjTM3ihrpIFX+svZ8SPwYbbzTcM
         lWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Or0lYQVNJ3ZFTvEKcGdp6AoYMkJnpUEvesCucB/s/eA=;
        b=Msf2mls/8xtgr0wdqajnuR0GdNcKhXArtN36q3EKw7WjDFPzaQyHf3ci0SWWBEl9q4
         ttU2EvFVWTajUUIdSwBHE9AMwqYGah/6fcOWGecmk69pOEwjF2Ug2Me8Py4Nh7OMM19C
         q+pxN7LqZfLUx4CWAYM/4wUNOA5WUhf59CajlXYTT9W9wbxDD8xJq5byxxQ7pTtRwAj+
         tc+iwGG6+3BrH37SS5fObwGgVcs4+s3a+h0+mJD1GYidsLVKBrbdMNNVdoMhBV1Pv6m9
         y4K3GwqDjcRapD0fk3dH94vmD8o52tb3Ng9vj+Rn0RZKU/rcThwTIvRcOodZk39yyiWh
         Fxdg==
X-Gm-Message-State: AOAM5307CdfLsqtOBh7tGKYhTabe6OdqN3Hf3t/C1rcfkkbHiABzFuf6
        1SSXlSosf0Jq194YgF3fXz8=
X-Google-Smtp-Source: ABdhPJz4sWveRvaDilxkO9hwX6+QdFoRWNRQHSqXz94U8JBhMiIIFwRF5pq38V9KwcotVknmy0Yr8g==
X-Received: by 2002:a2e:8799:: with SMTP id n25mr24136611lji.416.1594132169997;
        Tue, 07 Jul 2020 07:29:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m15sm227262ljp.45.2020.07.07.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:29:29 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [EXT] [PATCH  2/5] net: fec: enable to use PPS feature without
 time stamping
References: <20200706142616.25192-1-sorganov@gmail.com>
        <20200706142616.25192-3-sorganov@gmail.com>
        <AM6PR0402MB360752A10C9529B13051C7F2FF660@AM6PR0402MB3607.eurprd04.prod.outlook.com>
Date:   Tue, 07 Jul 2020 17:29:28 +0300
In-Reply-To: <AM6PR0402MB360752A10C9529B13051C7F2FF660@AM6PR0402MB3607.eurprd04.prod.outlook.com>
        (Andy Duan's message of "Tue, 7 Jul 2020 04:05:11 +0000")
Message-ID: <871rln9z5j.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Duan <fugang.duan@nxp.com> writes:

> From: Sergey Organov <sorganov@gmail.com> Sent: Monday, July 6, 2020 10:26 PM
>> PPS feature could be useful even when hardware time stamping of network
>> packets is not in use, so remove offending check for this condition from
>> fec_ptp_enable_pps().
>
> If hardware time stamping of network packets is not in use, PPS is
> based on local
> clock, what is the use case ?

First, having special code to disable something that does no harm seems
to be wrong idea in general. In this particular case, if PPS is not
needed, it is still disabled by default, and one is still free not to
use it.

Then, as I'm not aware of a rule that renders PPS based on local clock
useless, I'm to assume it might be useful.

Finally, as an attempt to give direct answer to your question, suppose I
have external device that is capable to time stamp PPS against known
time scale (such as GPS system time) with high precision. Now I can get
nice estimations of local time drifts and feed, say, "chrony", with the
data to adjust my local clock accordingly.

Thanks,
-- Sergey
