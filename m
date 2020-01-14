Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A88C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16542187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jlTtnwmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgANNqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:46:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46014 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgANNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:46:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id w30so12409424qtd.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=FJt5ul6jSl2oFgQgoNYCrlZqJ8ZxSmr3QhwWHFt0fl0=;
        b=jlTtnwmXXaDZbMLFdDf9rwr5nOnDzERvvJZeZRJJ4nklL+kf4y4RYe2uFCwecObjDt
         NOpcGc8JN0hIY1RA5TJaAGT2Kt+Br5DTYoXKnDBA6D4vWMDVIy9akjaGEezKyscsmgF5
         1JVRcnV+SPxc81HX2DRsNQ6LmeYErSfjszdJ51njd0gaYDjIsc2qY96jQlmFvbcH15J+
         w9p1jCZ4uLAhjRnUEAQa8lxV+MMYSoz0V+zv6zBMTYtoPlSsKHW4V9RwFyqjLHBfmnKG
         C7ejF5aUKxM5mf46atR1oNZ8r9qQSV3ahe4YHWM6LJN1Ah949eVDQRPfPLzvE8K5iK0Y
         6U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FJt5ul6jSl2oFgQgoNYCrlZqJ8ZxSmr3QhwWHFt0fl0=;
        b=eXsJ16oWquOEg8Z7oD1i/QZdLJXaCRCx4zG5FfPvwbiYsboZGFChcTmX8tve+spgI7
         3ZSjDjhUXMOs7HNn1c0KwfMPkdAr3BpTRt/4CgDYrKYX3dzfvl330D9jL5o6+1nePIAa
         BJLw310HaVcAfjlGJdmkBcChTacOCELY7fH8MBIyGkApxLe+t7W3ESN185jeH411nx2a
         ajGiWqndVA+4z1XULO17mbhp1vQnHbGrQwPOqObf8O6Kl0VyTNNAF4zscJ5ebuc+Y9wp
         AGHn2xBXx3/rxPT0Qf575Flpa+2R36DguWeceinkoPZ2WgLJR4Rz/xzMSZqhct0CwwqT
         tNZw==
X-Gm-Message-State: APjAAAUuF0IwKNpyUnS02ZIeL71NAbeSeVKmz4lm5FFtPTCwr7IiOOpy
        weDSIZpWoVndh84Cz3yBJbG5opAVQwPW9w==
X-Google-Smtp-Source: APXvYqwjloJcjp9rPTzCKEyvILBYokgQ8xivl6xDKlKiin4V+lyZt1nRX4QTpnG8/kBXw6NfMgK6Tg==
X-Received: by 2002:ac8:a8b:: with SMTP id d11mr3570022qti.94.1579009582711;
        Tue, 14 Jan 2020 05:46:22 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l44sm7724328qtb.48.2020.01.14.05.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 05:46:22 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
Date:   Tue, 14 Jan 2020 08:46:21 -0500
Message-Id: <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
References: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
>=20
> This macro are never used in git history. So better to remove.

When removing unused thingy, it is important to figure out which commit intr=
oduced it in the first place and Cc the relevant people in that commit.=
