Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAC2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEDA2083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="qQBpX7Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgIDWoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgIDWoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:44:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086DC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 15:44:15 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c142so5372343pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7w7+tvnW1G+Cle3enHiPY2ZUGZs43aoQoOoR2xnTfDk=;
        b=qQBpX7EqHscfN/xttnOIq269jQJMhj2p5YKvSz2dLaR5FXlmfk12gczTp3DWFoO/qt
         7tcvyb3ikdBmtwLr802xJ1ToVZPpjfy904wMElH3hQzVccak/k+9zFg0wCTJjZddGDbB
         xaxkaogbPyLlh+OYjSwI4qwbzT3D9RkeKgrgC8yAmOOvLHphBHx93fBP1iK47HYk2C4Y
         sxipObGsP3wAE8aM/O44cj8+qn1SGc48Q7r8X79oDvMR+zpvZ3hs7eHEkMlPW1WgZ+lp
         FLZKWhg1+o4pMBIrH5DcZApKoxeWvWDNHxXe05FvKLWr7q07292BhPKSC9M6xOtYYb6+
         wgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7w7+tvnW1G+Cle3enHiPY2ZUGZs43aoQoOoR2xnTfDk=;
        b=f3yP5u+k+mHl2Kiv5VSi6PWIxXDa97e0qv0vp+38IRkaSmAq2H+EQMkle0CAxYqRbx
         pQGhA86APVr6DH2rYIIywYlAmfBTyV1Mqs0Yt8U05A8JBliLPAUN5zezqhN5G2nSF+jn
         aZyKXYexjHiF8FCT4FwYYvP3GbxywO7QE0DEACcZnyf+Wc2qE/ByKlWbVC7JBH4vxVci
         aIX2+SvveZ11A+QKVrTJ0Yu2iD2j7NccHLrnm86R3IEMS4G8B4TOa2xtrdA5cuLLBCqP
         FstzMHFh2UBOL6vLotno+k/DpcmfLWt6G6zY/FrKfdu+g1jxKhhbNl1vvfU6M/uhft1I
         KbdQ==
X-Gm-Message-State: AOAM533oathy/3EpFFtvmxZ7rIcL2m/jiV0GtgjrUEx19sb5WzskS6UP
        8n90fzsJIoO9+KwO09z01by58w==
X-Google-Smtp-Source: ABdhPJzWWKRj+bDiS1qmtSMkbPL1RAaTzGIy5yzHODOnqUWlpjXdHPYbYeDZw4QO8vAuAcrVeckjPA==
X-Received: by 2002:a65:6282:: with SMTP id f2mr9117908pgv.163.1599259454873;
        Fri, 04 Sep 2020 15:44:14 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id kf10sm6049017pjb.2.2020.09.04.15.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 15:44:14 -0700 (PDT)
Date:   Fri, 4 Sep 2020 15:44:06 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <roopa@nvidia.com>,
        <nikolay@nvidia.com>, <jiri@mellanox.com>, <idosch@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH RFC 0/7] net: bridge: cfm: Add support for Connectivity
 Fault Management(CFM)
Message-ID: <20200904154406.4fe55b9d@hermes.lan>
In-Reply-To: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 09:15:20 +0000
Henrik Bjoernlund <henrik.bjoernlund@microchip.com> wrote:

> Connectivity Fault Management (CFM) is defined in 802.1Q section 12.14.
>=20
> Connectivity Fault Management (CFM) comprises capabilities for
> detecting, verifying, and isolating connectivity failures in
> Virtual Bridged Networks. These capabilities can be used in
> networks operated by multiple independent organizations, each
> with restricted management access to each other=E2=80=99s equipment.
>=20
> CFM functions are partitioned as follows:
>     =E2=80=94 Path discovery
>     =E2=80=94 Fault detection
>     =E2=80=94 Fault verification and isolation
>     =E2=80=94 Fault notification
>     =E2=80=94 Fault recovery
>=20
> The primary CFM protocol shims are called Maintenance Points (MPs).
> A MP can be either a MEP or a MHF.
> The MEP:
>     -It is the Maintenance association End Point
>      described in 802.1Q section 19.2.
>     -It is created on a specific level (1-7) and is assuring
>      that no CFM frames are passing through this MEP on lower levels.
>     -It initiates and terminates/validates CFM frames on its level.
>     -It can only exist on a port that is related to a bridge.
> The MHF:
>     -It is the Maintenance Domain Intermediate Point
>      (MIP) Half Function (MHF) described in 802.1Q section 19.3.
>     -It is created on a specific level (1-7).
>     -It is extracting/injecting certain CFM frame on this level.
>     -It can only exist on a port that is related to a bridge.
>     -Currently not supported.
>=20
> There are defined the following CFM protocol functions:
>     -Continuity Check
>     -Loopback. Currently not supported.
>     -Linktrace. Currently not supported.
>=20
> This CFM component supports create/delete of MEP instances and
> configuration of the different CFM protocols. Also status information
> can be fetched and delivered through notification due to defect status
> change.
>=20
> The user interacts with CFM using the 'cfm' user space client program, the
> client talks with the kernel using netlink. The kernel will try to offload
> the requests to the HW via switchdev API (not implemented yet).
>=20
> Any notification emitted by CFM from the kernel can be monitored in user
> space by starting 'cfm_server' program.
>=20
> Currently this 'cfm' and 'cfm_server' programs are standalone placed in a
> cfm repository https://github.com/microchip-ung/cfm but it is considered
> to integrate this into 'iproute2'.
>=20
> Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>

Could this be done in userspace? It is a control plane protocol.
Could it be done by using eBPF?

Adding more code in bridge impacts a large number of users of Linux distros.
It creates bloat and potential security vulnerabilities.
