Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CCC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DCD215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbHCaOCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgIGGgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGGgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:36:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00B5C061573;
        Sun,  6 Sep 2020 23:36:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c3so3766695plz.5;
        Sun, 06 Sep 2020 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fbHCaOCT73QEitsORT8A7jULECshSkNFsfN0lqxLnv9NqtLuZTNiX299eqFsSn/i0H
         XMaY+57ZpeMCy9gD/sNhsDPGufEugVn3KjnZ+OJuMYTDHy967E6y5zQ+tY8J0ehM58Q9
         okbx0KCZthd774jTBDaqQ82+5V5gM1Qw9yhGYtouHWThA3P7v1+gpX4t/J88Jj7BGNE7
         CbiK2/6h2plBhRy9hZdcNAioNjc4IXErPDRGh/NcyVYimkrJ9ffD/2cJFyHnQ6isZM+T
         OwSW01Va2UNJWrGX5dr3UwV15jtf/OqmS4qGkgKEEVfJaE0e+R2/litSe+ceLyzu9iSY
         zJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=cBvnYGk8b8kninXFlaAggVt3SQiUu839TQrn/LAs65AV+t+iom66aCjU+/3dSxyvFx
         x+qjtxNCV5+BYDlmsvZDrtwnG5FgFfnS4XLCOK4ltGWhFKcpcokZnMPC3aboG2CLB3yO
         Pj3dhzVq8+Zlf84PhsHXUF814GrXJ0r8b4+UYpyJITsoAoj2Vwm93zEGtrsH6aX9C9eA
         CTEkbrjLP9q4zAg/eMRXFj0r+4a05jrrF452cFPC45eQI4huDYYhTQiOvlB3lvZRkCWw
         fS+IkP1ZfpdxdTjYam2pkQ5/MAleofrJy5aM/YGodyETH7ZbS0F8rLqCOzdcLt7ISvbX
         2k0A==
X-Gm-Message-State: AOAM532PA73tJ3KwaPfbinsVN8G4x7aLMVssNXtKwdhca9et8KoLoteL
        Gn72RAH/NA7EULCTe5GN5QA=
X-Google-Smtp-Source: ABdhPJwgx99BRCDhQRZTixm/9uPVMLMpWFBKTUcxE26SgTtzeQ5XhqrvRSSOK6jPTDclOjwHDi/NDw==
X-Received: by 2002:a17:902:a50b:: with SMTP id s11mr11590419plq.136.1599460573455;
        Sun, 06 Sep 2020 23:36:13 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id md10sm11631756pjb.45.2020.09.06.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:36:13 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:04:14 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 2/2] fbdev: radeonfb:use generic power management
Message-ID: <20200907063414.GC29062@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-3-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806072658.592444-3-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


