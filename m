Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF7C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1B215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IAWbyeeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgEGR3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgEGR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:29:08 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A8C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:29:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id p13so3045018qvt.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bMOaygytaavUP+3oXmRtBKd6QdpGHoNfPxDGHrJDoho=;
        b=IAWbyeeUHvkBMoYNzo44CNsvAtPLJtb6pI954PKHBckQft4I2EW0SJ1CkgznjDz3a1
         oUENBjemKejGoMt8nuW7lQU5bMi0dUJbfUcPPJ8/pfINMWh1hUVpxABmDJbd4tA4QTeM
         gAAohzYy5f6BGgpQdDhIDAk7SpihQpmF6bIfC6OZ58ZVoZmWI1dKHecJhSWuMgqyi7B6
         ETtgdqCiHJ8aG83NAYYCHvXoYDsD64SQQzwBS+RFSccPUyYoTg0FOMACaOqHuTpXAENM
         U5QSM9cFpSyQi+R+kXVXIOUMCDYuItpbmcNHl67k84/2cF3R4QSjZU/sVYoYq6cY0Y5C
         m8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bMOaygytaavUP+3oXmRtBKd6QdpGHoNfPxDGHrJDoho=;
        b=Vj/j3NULjlcs8Wnl0tnvWo3B9Z+i/fVwO++xos1a7cyyQt/ECcKkoYdxs+dHpHgke2
         7LDaZn5Gbmis7IRx+V3wbh38H+4hTqCLlLZfL8xxUX9I2VAzpueM7Dwj4lSV4VCswHZn
         EWroSYD5fbwE2a/L0O5UUYyYAc4ZCa5M/PMbr4Nsbs554gF/RSgtJZ0sf6Gt2L71RAht
         XJ62CqGdF6HgAWd7RDr/9tg6AsJ86prStmK/Qtx9Bjoqk1yD6aMPKbF4oY7Js/CiKUHX
         SN7mZn2LLpTHjJvR6Fg6W8J2V0TEsakZy/Pcv4y7GtyuaIT0wWxfpGDzNSs7QWqKTdtC
         JkBA==
X-Gm-Message-State: AGi0Pub2bRfS1NeKqJU1DLtY6JgxZYIDsJVSF8bLkVrws50VkSHHNlTl
        jmVlMm91T2Tq1EAuyVwNA1AQfw==
X-Google-Smtp-Source: APiQypK2y+suGLYML/+oWo2pLhvykG6idqATlpGsx4Cksh/5yVouQrtGlxihrZcxPMP3VpS71oY0BA==
X-Received: by 2002:a0c:ea28:: with SMTP id t8mr13693929qvp.174.1588872546164;
        Thu, 07 May 2020 10:29:06 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a12sm3935981qko.103.2020.05.07.10.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 10:29:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and call_rcu()
Date:   Thu, 7 May 2020 13:29:04 -0400
Message-Id: <40B2408F-05DD-4A82-BF97-372EA09FA873@lca.pw>
References: <20200507171607.GD3180@gaia>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <20200507171607.GD3180@gaia>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2020, at 1:16 PM, Catalin Marinas <catalin.marinas@arm.com> wrot=
e:
>=20
> I don't mind adding additional tracking info if it helps with debugging.
> But if it's for improving false positives, I'd prefer to look deeper
> into figure out why the pointer reference graph tracking failed.

No, the task struct leaks are real leaks. It is just painful to figure out t=
he missing or misplaced put_task_struct() from the kmemleak reports at the m=
oment.=
