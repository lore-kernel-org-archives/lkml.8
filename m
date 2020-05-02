Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C97C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E339A20787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb8o8JMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgEBLlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEBLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:41:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD36C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 04:41:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so2901075pfx.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5AT7+IpSsbXSBIYQELAFYrNbOFWME1dAXDAJ7qmsqGs=;
        b=cb8o8JMo4SX8ac6F0+/HNxULbKc4UQsIuHnCuRiHEZkq3Nusku4/tvSi6oCem2uqqN
         pVyLF5WBGjJRY7aqU0qeQeKQPLddzlpheoVyiY6NRTWr3wWBFLOw7PUYFuSx5o/pASJo
         LTiSNJNtjwVjFnJRRG0PaASJ7a2hLycUVE8PcIQ//VihgYAqtM2BA/sJfWwJ99IbLpQo
         zcyGQhJlPW7nL8kO5WtOyfY4Y6ciN/u7iJYUXnlE6gR6g53ebq+70It/F3s9WoumDGI6
         6Dv+oXeHaWIjqJ0AxXxRLXba6szJwk2TeTtQQnVTwCkFjC+f8Xgfo14FxDK0snBq3h4T
         UHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5AT7+IpSsbXSBIYQELAFYrNbOFWME1dAXDAJ7qmsqGs=;
        b=TdJ3ANiP/mu7Em1CgUrZdpdO2mqbAvziueQbcOZnG/8+3umemOPU8xv/lFEiBKhNry
         5UECxG13xVpj0Rnh2oq5HRWyuhXn/g2mfdu1NOpErSF+c/vPEmlpn9csZ1mSHIIYYpkm
         UAXI9KtJRlaZEOkEabe3j3bnxi32T/vwhLBSyoVztSm7RJtAXj1G9bBid/QxM2wvVsBr
         slPNYqH06PxbOrzeCEaDdVXCkqnGrj2VTe1UxIG1XDhaAJcdwtQbYpALgIe9ytTgpait
         RXlkZMNcsV37SULXzc8XN0mzFsfM4FQi8Cxqyhe1Laqv+USMv2Hi2olVqoKg7ej2ceRg
         74rQ==
X-Gm-Message-State: AGi0Pub1VV7dRzJitZUiQBfuKEBwO6jifLyZ+wPDcU4YFw1Kwpo0rS0D
        NsKiMpwhSDUaJEfLAiYtE7A=
X-Google-Smtp-Source: APiQypJn8zVCOtsAbAbRZ1Z0A1hzS9ZvdUVdyPxsKbbAeoUVvPTZLYoh5nPwD3m3QAlcTvnNBYN6XA==
X-Received: by 2002:a63:1c50:: with SMTP id c16mr8272838pgm.255.1588419678667;
        Sat, 02 May 2020 04:41:18 -0700 (PDT)
Received: from localhost ([203.220.177.17])
        by smtp.gmail.com with ESMTPSA id u5sm4002994pgi.70.2020.05.02.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:41:18 -0700 (PDT)
Date:   Sat, 02 May 2020 21:40:46 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 1/3] powernv/cpuidle : Support for pre-entry and post exit
 of stop state in firmware
To:     Abhishek <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc:     ego@linux.vnet.ibm.com, mikey@neuling.org, mpe@ellerman.id.au,
        oohall@gmail.com, psampat@linux.ibm.com, skiboot@lists.ozlabs.org,
        svaidy@linux.ibm.com
References: <20200427021027.114582-1-huntbag@linux.vnet.ibm.com>
        <1588035100.usm3gb816q.astroid@bobo.none>
        <66ce544a-c1bf-4e84-2a7c-7480bbc0e12c@linux.vnet.ibm.com>
In-Reply-To: <66ce544a-c1bf-4e84-2a7c-7480bbc0e12c@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <1588419467.wibmtct2qc.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Abhishek's message of April 30, 2020 3:52 pm:
> Hi Nick,
>=20
> Have you posted out the kernel side of "opal v4" patchset?
> I could only find the opal patchset.

I just posted some new ones. I have some change sfor the cpuidle side
but I haven't really looked to see what needs reconciling with your
version, but I'll try to do that when I get time.

Thanks,
Nick
