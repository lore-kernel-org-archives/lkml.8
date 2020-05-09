Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C4C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6863D208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J16hc94N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgEIEuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgEIEuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:50:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F541C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 21:50:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so3019093qkh.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1JFY8qJmZXd/aUl9gDLLurD+wehBfsqo8Bz40G/nWw=;
        b=J16hc94Nk376MVeMGTdJs5OJAz/Ehej4THCEf4foNANL5Yu/B80oKDrU/aEmsxYPfE
         R6PyDEMbV0fqJYLmIXzRt4HBWSDOIp6+311zEYOxL2u8OEC7+60bkC3pBAib3EXph7Db
         TEgkBKRmiOWR8nxpGR7MNewvquOMd6dRRkxm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1JFY8qJmZXd/aUl9gDLLurD+wehBfsqo8Bz40G/nWw=;
        b=Ed50kiBY5vqdoNZ/JXhKL6F0sMyTgpbQk694C3so1PFxNcAekHvUxjPJZefY1tsUie
         qudGmRtgsFLLJvXKvaXcjnNa8rT8xrQ+tN33L61QY2KYzJQ8t9Fh3J/TpyzwbqINXks5
         hlc/q2dc6ayDxcyhNwn4XGHtbkBoXEgMpAhzj2aduPFIqfUdVYtKspjoHQ99byKfzgr2
         IpEtKsmc41gePTfK5+ZDDap+Y9xcRHY9ek68a6OOT5odPOLhZ6rPXGoZJwr0Cs/3ifYH
         ef5xED30DNKFox09hG0a/5+tGVnucj6gxhXe5Jwk+/+sIE4eFqdBiJA0YwM1HcTqWIo9
         U+Og==
X-Gm-Message-State: AGi0PuYl1ihwl5YLanGzgplsYKKoy0i2yq2zaGP8ROSuyEhzeMHf4IRQ
        +lX4s0tfbb9sjIk1Us2K5e7cpV1f55fSlkHL16AO/A==
X-Google-Smtp-Source: APiQypJBp2r6Es5PVpPUyc2m1NAUrTMh1P00GZIlWuu0gAXEIz+sgXN+lihgtlNrzkjKnptXRPhsXJbgN7ojbaB5dNU=
X-Received: by 2002:a37:7443:: with SMTP id p64mr6032310qkc.269.1588999812631;
 Fri, 08 May 2020 21:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200508224026.483746-1-colin.king@canonical.com>
In-Reply-To: <20200508224026.483746-1-colin.king@canonical.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Fri, 8 May 2020 21:50:01 -0700
Message-ID: <CACKFLinBL4QCT6YcTn=exkHAitXHd_D_XR0zHwT1zuMfKTyWug@mail.gmail.com>
Subject: Re: [PATCH] cnic: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 3:40 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being assigned with a value that is never read,
> the assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
