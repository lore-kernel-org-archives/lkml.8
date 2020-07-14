Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02125C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D391A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5DDmzFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGNUzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:55:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728002AbgGNUzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594760116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IG4HUAqsDTrwc0sdFRqFLUeiV5cP2XX7c9955RD/JLA=;
        b=K5DDmzFAy7VFQuXtuDs9HG3Wn5jRuEVncTpVsJYbK+1htvGSSIJ0Q430Ge1yeS/8jG9TTx
        KWJy7DvusgP1r2DxeeSd1n81GP7k9P2gQSesGmltnnS+S+Twj1qfmXHE0POB5s0R1Hz3V1
        3VI6DzU7pJg/aX37CnDk7zs9h84BhLY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-_aLwibdaMEqohkiU8eEQnA-1; Tue, 14 Jul 2020 16:55:15 -0400
X-MC-Unique: _aLwibdaMEqohkiU8eEQnA-1
Received: by mail-qv1-f69.google.com with SMTP id em19so10469044qvb.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IG4HUAqsDTrwc0sdFRqFLUeiV5cP2XX7c9955RD/JLA=;
        b=oBXQEcuZ2typ/+TbuFFq62Ph+Eg8W94dPAvoXhJZsRJlub8BOaeTyX7x7ClhTM0jLV
         uY8l/HdTUdJEzqwuetx5kjeSP0VLG38at41IM3PmIz+u/xJ/zFJRhgQsjQclISLdGf8v
         5lXCORboAF4jfF8wVbNRmty96SLgt64bo8ANfx/EJc4m0hdEKF8c57AKeC9Mx9S+hci7
         nP0mAetU88yrlg3QQXbSLN00QCkfF2dLpwV+x9lBxsw7fAOgWqLeY5E3Ig2fpKtie6FN
         6Dsz94XSW4m3CiDdwK1dqIaHY7wWTNSpUr3yT0RNyKLvbYRADX9amxlEur6SfM03wyI6
         08Nw==
X-Gm-Message-State: AOAM532nZk1YuA0YSapPfM0Ed7h25/48RXfax2hZ+uGDr56f0kLVLiTX
        sMMPbAxYCkapVo9p/8G1l4RCmUiPIF9qTEj2x7YGGQUAx1hzlypSDn6KmKRUL4kIS7ACOSkO2z7
        tu4Rv5O/hqPhwOzgDYK8NO0Z4
X-Received: by 2002:ac8:1667:: with SMTP id x36mr6817831qtk.344.1594760114507;
        Tue, 14 Jul 2020 13:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSc9JqI/7mPb4eGFhz4PiDFiEHI9lotYrjvFjoxySGjr6nl4C6ZtZQY6a3Ef23EDowBCDgsA==
X-Received: by 2002:ac8:1667:: with SMTP id x36mr6817798qtk.344.1594760114128;
        Tue, 14 Jul 2020 13:55:14 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id k197sm24103418qke.133.2020.07.14.13.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 13:55:13 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com>
Date:   Tue, 14 Jul 2020 16:55:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 11:03 PM, Mathieu Desnoyers wrote:
> Recent discussion led to a solution for extending struct rseq. This is
> an implementation of the proposed solution.
> 
> Now is a good time to agree on this scheme before the release of glibc
> 2.32, just in case there are small details to fix on the user-space
> side in order to allow extending struct rseq.

Adding extensibility to the rseq registration process would be great,
but we are out of time for the glibc 2.32 release.

Should we revert rseq for glibc 2.32 and spend quality time discussing
the implications of an extensible design, something that Google already
says they are doing?

We can, with a clear head, and an agreed upon extension mechanism
include rseq in glibc 2.33 (release scheduled for Feburary 1st 2021).
We release time boxed every 6 months, no deviation, so you know when
your next merge window will be.

We have already done the hard work of fixing the nesting signal
handler issues, and glibc integration. If we revert today that will 
also give time for Firefox and Chrome to adjust their sandboxes.

Do you wish to go forward with rseq as we have it in glibc 2.32,
or do you wish to revert rseq from glibc 2.32, discuss the extension
mechanism, and put it back into glibc 2.33 with adjustments?

-- 
Cheers,
Carlos.

