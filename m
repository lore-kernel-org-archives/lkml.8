Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A19C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AE720708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="R3+YB1cN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgEKQoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgEKQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:44:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:44:28 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c24so2060517qtw.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xntjjopiDXJMJjTZuW8sCWxRZJFhujdIbxmRfLLYdZY=;
        b=R3+YB1cN+Nl50Z+4XOutaE6RbDh3I1hicUpoZVR51l4aEOCM55H45TC4bPYOTm86ZX
         b5IsheVHjSMZNIf2kvZQ9SkD765IG7dWLxgB2Xa2S4uKRpRYgj4jAhFnkfQ/X86TXgov
         8Zm0EhlJV89EFD60gyf1+P3Hiu/mSzKbL+v6+gG/+nUUx02RDGHny8HkGdhw5mIilCfo
         00vGZf5T/uZ8qGGCRkRoLRy4XYLKFNmhC44TYmARKWmwJFWKdfdabXtg/hUvPqAbyhSl
         YyJPg5H5gdrJ7XWqJR9Fx1f+sMQNrpVkEVxsGrSEPMuuwmTokiqePoPoa4hSDDpr4uPh
         HWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xntjjopiDXJMJjTZuW8sCWxRZJFhujdIbxmRfLLYdZY=;
        b=fQkd/n2WPcSEjmQ7XkimKFagLISHjIDsY3pJ6VK2d1iHSZPAP3uh5plul2UVphMzL4
         sSLjNmVpp0FYpfEy/xae87BB1mE9z1S4iwrFkYA2UDDhuq4kjZ6Haq1du0dRkkG5ZeH6
         9bZWbokYgWf0xEx3zR3DBDT+uCwQUvQ4zqKqcZtmc2NmnJ2OIx739V/ABOllbfxlxQBc
         YW2M3ZvYpKaZTMtySNCVVbRR+e/X559i92/sYs6UkCwfhEeoz3vT49UGmk9PbkjEdyfd
         zP3htnxs8A4CKnqKQU3tFKB6kWZTVX7m6KPLCJecCPrEM2dw7DDnby4BSIz+CHxIRkTa
         xUGA==
X-Gm-Message-State: AGi0PubFHCBbY6Dm1H70XZlBTO7S1W54oXaP7H6KwC1mMol9ja2Jilv4
        aIiSFzzBf+R+7UL0qHM+7wvOyQ==
X-Google-Smtp-Source: APiQypLLbA9yNXaNHmjVD0nySA4tTLMLokWE1HDS/Dj2+ZU+FlvypkaUjLuejrMRGpC/TZuPJiuejQ==
X-Received: by 2002:ac8:4447:: with SMTP id m7mr17283994qtn.372.1589215467856;
        Mon, 11 May 2020 09:44:27 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s30sm7749259qtd.34.2020.05.11.09.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 09:44:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in osq_lock
Date:   Mon, 11 May 2020 12:44:26 -0400
Message-Id: <D8F8F41A-F785-4E17-83CE-4101137ADC5B@lca.pw>
References: <20200511155812.GB22270@willie-the-truck>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
In-Reply-To: <20200511155812.GB22270@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 11, 2020, at 11:58 AM, Will Deacon <will@kernel.org> wrote:
>=20
> I'm fine with the data_race() placement, but I don't find the comment
> very helpful. We assign the result of a READ_ONCE() to 'prev' in the
> loop, so I don't think that the cpu_relax() is really relevant.
>=20
> The reason we don't need READ_ONCE() here is because if we race with
> the writer then either we'll go round the loop again after accidentally
> thinking prev->next !=3D node, or we'll erroneously attempt the cmpxchg()
> because we thought they were equal and that will fail.
>=20
> Make sense?

I think the significant concern from the previous reviews was if compilers c=
ould prove that prev->next =3D=3D node was always true because it had no kno=
wledge of the concurrency, and then took out the whole if statement away res=
ulting in an infinite loop.

The comment tried to explain that the cpu_relax() would save us from the inf=
inite loop in theory here.=
