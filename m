Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED420C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BA520678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XacOx8Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHaRgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHaRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:36:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:36:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so9258124ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=I3WeqjVx4wKF3MWJ0CP0zAUX9Wy/9s2/ETXzMNYwB5Q=;
        b=XacOx8VmM+yH++N7e0sIqOtJmWLNk9ffuc2ukCaUK4p60sLubP87STHrtG3AOm3bau
         AOwUQRCyJO/rbDScOA0psV5NrV4+NNJ06VU+2rL+exdRc4AkbpvubnNdccmW5U2bBvF4
         ggoSFYDcAa3afRJhPNfMEzDhbXG2vhLqJdZH1jH1/y4WSEKHi+oUXAxWE3gFTcRR+Yio
         s/EPdKmtrQHlXvstI9240h0DASqJXBpCpL6sbM9IYBYyuN5qfS/hNvhtrFk/vv5VaZ1j
         ypaf6XDFc7mXQOg4OTo+NjGjmP7QDfDe25dER3mmSMMRzoMtFG6S/MolgT7nx6EBcD2g
         zr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=I3WeqjVx4wKF3MWJ0CP0zAUX9Wy/9s2/ETXzMNYwB5Q=;
        b=LEDd/DADDNMaFS/uCnpywp2fa+mVjlDLbMA3JZj7KRZrbvkSoCR4RALQCi46VrYTpW
         wcj2/OnDM3Pi61z63i+7eZ3IHOGur+1OaVrMjdNQC04ILjrh+ZGiBOUWrV7e+qzk1kf1
         P46zh4JEdMEdprpOFc/7Z69pbGCyF5gaC0wQJyS/Doh8smCOhC0SYoH8Byl6XG66O6ck
         QkwLJOwBAdwZBS3zq8wRT+p8zG91/YexQpjEbcqP+IhtU794loJYIX61s/xSZb7gihRT
         BFmS7qHjuttj4iAoi5NC91rlU/+yuosZiSS215+rkPc1gRmKYYD/NweLUq04Brc5NVSz
         k8Uw==
X-Gm-Message-State: AOAM5302Ro2BwAfm0MNm+rjyFqq+ou3kjXu9N5v+3bjM6JbWbv2hKhG2
        ZrPeJ4LYHchMERhM+5cUTKRDggtlv9I9DPfbixQCGefeBtoiiA==
X-Google-Smtp-Source: ABdhPJypgdPk+DcH08XoTc3kQbk41mTVJZ00yFTKgS9NOuSvcp51PRDg74ysxyTvhvl4ZMuaq81IfvCMh7Z+/SN2RvI=
X-Received: by 2002:a17:906:2a49:: with SMTP id k9mr2066689eje.117.1598895368429;
 Mon, 31 Aug 2020 10:36:08 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Curtin <ericcurtin17@gmail.com>
Date:   Mon, 31 Aug 2020 18:35:57 +0100
Message-ID: <CANpvso7UExmwsRDvz_mkbYLT801bBzFcjMQiwtJZfhvn=L_7ww@mail.gmail.com>
Subject: Trying to run mptcp on my machine
To:     Kernel development list <linux-kernel@vger.kernel.org>
Cc:     fw@strlen.de, davem@davemloft.net, dcaratti@redhat.com,
        matthieu.baerts@tessares.net, mathew.j.martineau@linux.intel.com,
        pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I've been trying to get mptcp up and running on my machine (xubuntu
20.04) with little joy. What I did was install 5,8,5 kernel from here:

https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.5/amd64/

Reboot, tried a curl:

curl http://www.multipath-tcp.org
Nay, Nay, Nay, your have an old computer that does not speak MPTCP.
Shame on you!

Checked this flag:

sudo cat /proc/sys/net/mptcp/enabled
1

Even tried to run this guy in the kernel repo with no joy
mptcp_connect.sh. Any pointers to get mptcp running? I couldn't find
too much documentation on how to configure it on GNU/Linux.
