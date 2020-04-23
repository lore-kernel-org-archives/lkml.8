Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAD6C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9012098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eHTRPV1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgDWKrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgDWKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:47:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E7FC035493
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:47:18 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id di6so2600336qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bBc1CHMMP5ULsArwb7u9wHSPCs7CVoGv3bVPmYv/xJc=;
        b=eHTRPV1AjtefgLCbW+pnUUa2VmW3ZjptdJ07lMZv6sDaPgq0mtW+pza0dD/pOWpOxY
         06wutMQUhexiEaQtgPAM0gRh5CMZfmaE+Lyt5DAhvoa1uzMp1km04JguinIjUJ9sbdae
         3oP3ejJnqPKcHjuUDYcuK/PA9MOgrG9WBYy/+9QfgAddyqixqfAi6LhA6c3YyFe7QNUk
         GL22ite+l2p4LBepmZHX+f/JFGfJcDn6X/CbOiS6GtysZlk95MXv+FOgxMTpOGBcWB9s
         ITKFCQ2ZGKth8h00hSWH2Xntl5GZSfWm7vv0FCzp6wEYc2N/XNyREBHmtKXyXk5AAR47
         y1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bBc1CHMMP5ULsArwb7u9wHSPCs7CVoGv3bVPmYv/xJc=;
        b=QzgYDUqR3WIOx/B5CjfmYRVuHnRQZi7tTI+99vzn9MUICdqHiJRaH0wXTR/cIf3A/q
         DC43HnH+emYINN22YSlA/y1iY7fbuKOL1mYSzYIr08x9MBdnge8zAY/4RvCEmDJ1On+U
         ZdbHF8djI1W9qY0d/sdS9RWKJnmtbiabRPkyzSSI4CD+aA082ao8+EFRqCnnxYuHH7ZO
         9uR6YOYqnv5S8xU/Pv43DWpdB9MqxgcFlld8bs8g1p73iYC6mVkKAIRQiTuT0DMJ3+eG
         0t2OEfPFip4GgQsWLbtRwY8/ei0zwtsjbTgxx00ZF/wfUhKUcuSj8NSittcuKBXXnksz
         r3fQ==
X-Gm-Message-State: AGi0PuYaeLLihP89nKypesT01NfkAyQ2ZUhNyfUwaLxt9i5AZV4F9/Mb
        7U8ii7FPSwrsIoyGqDpomc0403A45bd1cA==
X-Google-Smtp-Source: APiQypLEYXReCAJbhKMNFJdMZlYC8SIf7kupqC588GApDGOGm7YgoWpfGP690yChEjfk2fQ4AXBRPQ==
X-Received: by 2002:ad4:54c3:: with SMTP id j3mr3441613qvx.241.1587638836915;
        Thu, 23 Apr 2020 03:47:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g4sm1395543qtq.93.2020.04.23.03.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 03:47:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()"
Date:   Thu, 23 Apr 2020 06:47:15 -0400
Message-Id: <838855E1-35B4-4235-B164-4C3ED127CCF4@lca.pw>
References: <20200423060825.GA9824@lst.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <20200423060825.GA9824@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 23, 2020, at 2:08 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> I can send one, but given that Qian found it and fixed it I'd have
> to attribute it to him anyway :)
>=20
> This assumes you don't want a complete resend of the series, of course.

How about you send a single patch to include this and the the other pgprotva=
l_t fix you mentioned early as well? Feel free to add my reported-by while a=
ll I care is to close out those bugs.=
