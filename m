Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B4CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6852467B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WyAYDd36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBFPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:23:35 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:34771 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:23:34 -0500
Received: by mail-qk1-f171.google.com with SMTP id n184so1093303qkn.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=frwRu00RMnlq6x7glE4bsBI/4vt4kjRzTWP+kvpkLb8=;
        b=WyAYDd36JnCVt8YDMm8NHzFSyiqKrVRAPtZwlDtSRhLLeDtmf4gNx4PWfg5Yf41GA6
         r42deQ0bhRIemNw+5f24PcpodTWdbjDY3nHRTij+NdfNi33fOiErIe6klpPsvDEeUlDr
         aPQnBhJY+1GdLvQRVncUWkjtiDGilS/ebM08wNdW/wTqCo23x9vOoy06btD8KeCOT15A
         fRrVxGVqnPy1eUNi8dzpREXWWyQLrVVLx+pxLSdKL/tYjh2cI92R4NkvQcpPE5FbKZLW
         fIyVhlxF7YLYSXCJlbPPfVyN8bSvr72TAZosEfsLp2KG8i3sE6Tj939jUNMrHeIMBlfH
         66FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=frwRu00RMnlq6x7glE4bsBI/4vt4kjRzTWP+kvpkLb8=;
        b=Ba2NDZruqJgybKZH9IKe3I8dwIAftWWJ7Kf4YQh1tVA8UI/7e6YlCYCwhuSZEqtpuO
         187xoOZ2fyVrGMddirQgu3hSNpv3+aA+N3KNvxW3oGklIDOVq5UkYrlMPNmbiRZw94ef
         sDCcjWPi8yTwQI27EghMgM9BWoVS09KuRI1qluaE9FBAttaUAfOhWImm7f5w7h1KQaCO
         XaxGuch+wYeFfDxQ5qxnYBxomWYUK1myhMfw1Aev0k/DGfHTWp2alO+V2+PxMBc5pjVD
         MbpO3ofEGs0ynLpCy/FJqR3b7pJn5fQTVDYyH0Y1xU9MNGwOXvhDIRY50rHyPxzTGOX8
         d4SA==
X-Gm-Message-State: APjAAAVrZccKYtJO24IBjhMSMbLDS1bSWJEdqFZtDnxC7dxekWy8K0Ii
        rZzsVnTRjSmxcUK9TlATQsc1GQ==
X-Google-Smtp-Source: APXvYqxODNY0lyU+d/2Mjfhf75XtA41+EuEtLTiEI7kRR25uJvxQ8Pfk9BIhCaWvay53pXiH1rh5RA==
X-Received: by 2002:ae9:ed10:: with SMTP id c16mr2905732qkg.95.1581002613705;
        Thu, 06 Feb 2020 07:23:33 -0800 (PST)
Received: from ?IPv6:2600:1000:b029:8fd0:fd1c:a898:e3b9:6ee8? ([2600:1000:b029:8fd0:fd1c:a898:e3b9:6ee8])
        by smtp.gmail.com with ESMTPSA id 13sm1543881qke.85.2020.02.06.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 07:23:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: fix a data race in put_page()
Date:   Thu, 6 Feb 2020 10:23:31 -0500
Message-Id: <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
References: <20200206145501.GD26114@quack2.suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        jhubbard@nvidia.com, ira.weiny@intel.com, dan.j.williams@intel.com,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200206145501.GD26114@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> I don't think the problem is real. The question is how to make KCSAN happy=

> in a way that doesn't silence other possibly useful things it can find and=

> also which makes it most obvious to the reader what's going on... IMHO
> using READ_ONCE() fulfills these targets nicely - it is free
> performance-wise in this case, it silences the checker without impacting
> other races on page->flags, its kind of obvious we don't want the load tor=
n
> in this case so it makes sense to the reader (although a comment may be
> nice).

Actually, use the data_race() macro there fulfilling the same purpose too, i=
.e, silence the splat here but still keep searching for other races.=
