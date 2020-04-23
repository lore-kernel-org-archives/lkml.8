Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFE0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C103C20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+TLKuAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgDWKP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgDWKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:15:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65EC08E859
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:15:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so6160468wrs.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Skhk4DHSP6S49ay3YbxbGVfdsBzay3NHmVMdnxxjSrE=;
        b=I+TLKuAs2kcILC8r2y31+Fs6kHHC22w89oNz8ZAuEz7a/NwAHyHRhH49lQ99XqFuuo
         R3IhyHzvFan0ZxMjjmeJfK6vIg83WNw9iTLpInlpuRh0PdnRrn0QvWtkQOg44kqgRhvV
         6DE3DLosEbf6c35JWsxRezJggy2MUC2ISZmcIDlEBwPlnlZnKh5IFCFfY5isGVsrhkSe
         AhshvpJ43SI2JP/9sqEtpMJfPwKQBtcEIfCfOo9Ifjn3Uc+GWmZyiKDrdDwhi1TlvmcU
         OlaVa8Mi7yl+XSaQD426NmRdLYTQGFvtCyaSwMijaGAre7Qrmkw3FVmrCfkp2xlHM9CH
         1ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Skhk4DHSP6S49ay3YbxbGVfdsBzay3NHmVMdnxxjSrE=;
        b=IAfCb0rgNncHhllstT0sdHPO4b99KDcgRwZLPR3lJQ6/OkndwWcfPwxblAnea4O0Ka
         4KTQtqDfHgEkoC6hbGJti1x5H3rv+Tl+d6R6mBpCq2/1q1Zr8EBLiYKI+H/bqy5dbCGW
         3EcwRwxKAiZ8630Gf9bbfcLfbRB/gQ4xYAU3MOlQvn2AnYH3M0jIOjrSDWc7jN7M4xWO
         OxDh5l3yBp6CYNnkj5Ujeny3x/egAptlbw3gSLiq4cX0AVkvh2LNfEYfBZU9BzMteJH4
         +UONs/CyVK56O90iGuizFHubLSFUKkpjypAQSQrwi4djh/iJdo2uXw1I6aA+QtwcPHmL
         0Jwg==
X-Gm-Message-State: AGi0PuY1CYmhitM+jqPtJ42vRp/mkH6xLiSN067cCIXawNRidKw5l557
        VX7eUCA0ItlWQbJqWCarXCJjlIWdcBgEO/8nb2110w==
X-Google-Smtp-Source: APiQypI1r8e48tHFF0GT3T2PTE6IsJMo2BsxP2K03RKXkKpfdHnZXkmcBMVOlUzUr6+GY2um2U8mlX8yVowKNlWzFZk=
X-Received: by 2002:a5d:6887:: with SMTP id h7mr4078989wru.365.1587636954682;
 Thu, 23 Apr 2020 03:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200414160758.v1.1.Idab9dcdc7da549ed1fd5c66341fb8baffaee8d10@changeid>
 <84DFB53F-C60A-48D3-AC01-2C9C87BA805D@holtmann.org>
In-Reply-To: <84DFB53F-C60A-48D3-AC01-2C9C87BA805D@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 23 Apr 2020 18:15:43 +0800
Message-ID: <CAJQfnxE_-8u_f2R9Twnn0v+tuLYu1bXmLLC_C9T_JrZ-otJxCA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: add support for waiting
 disconnection resp
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Let me write a test for that.

However, I cannot seem to run l2cap-tester properly.
On raspberry pi, all of the tests failed to initiate.
On chromeOS, all BREDR tests pass (before and after the change), but
all LE tests timed out on init stage (before and after the change).

I need to find out what went wrong when I execute those tests first.

Thanks,
Archie


On Thu, 23 Apr 2020 at 01:42, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Whenever we disconnect a L2CAP connection, we would immediately
> > report a disconnection event (EPOLLHUP) to the upper layer, without
> > waiting for the response of the other device.
> >
> > This patch offers an option to wait until we receive a disconnection
> > response before reporting disconnection event, by using the "how"
> > parameter in l2cap_sock_shutdown(). Therefore, upper layer can opt
> > to wait for disconnection response by shutdown(sock, SHUT_WR).
> >
> > This can be used to enforce proper disconnection order in HID,
> > where the disconnection of the interrupt channel must be complete
> > before attempting to disconnect the control channel.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> >
> > net/bluetooth/l2cap_sock.c | 30 +++++++++++++++++++++++-------
> > 1 file changed, 23 insertions(+), 7 deletions(-)
>
> the patch looks fine to me. Do we have something in l2cap-tester or l2test that we can verify this with before I apply it.
>
> Regards
>
> Marcel
>
