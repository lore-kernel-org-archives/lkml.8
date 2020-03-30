Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE777C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9220733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0AtaP+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgC3Gmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:42:46 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:48015 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3Gmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:42:45 -0400
Received: by mail-vs1-f73.google.com with SMTP id m24so3776172vsj.14
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=SgUhaM94KxHd0Ro08h1q71zQtInjXYe3MISrs1wOyi4=;
        b=c0AtaP+cLTXgLF+GMK/DsFjr00PagA4ARWCFyYD5/DlaLY11hN8VDg0DKAx+eqH0L5
         4bvlVzSInOv/nWOBqdLmxcfzrMpbFyqhj7a4uWHto3x6Kv/OBROj+ZqUAIvQqbUNKwOf
         DV5WS0qzgTZqtVAKGs6B1oc4hc3XiYyvzPmINcfcTvqP+VALX6nn4bLpJ92up9jL7cmD
         mqUb0Uiphqfo1zr196ZqPVrv/i4kZJ3OxbXoZuYLE7xzZb5ABI7yTYd54G1hmRlwIgGZ
         jjY9iJPReyTNsg3jEVHmzXZb8ngs9B+k0X5FLICrHc79CGH8pq1zpMQjr5B+SzKf2kRS
         VNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=SgUhaM94KxHd0Ro08h1q71zQtInjXYe3MISrs1wOyi4=;
        b=pLPxQI2gIGwDvsNj9oeS7c4sEk8SOM6alSBTfqe4N9/e7vOJSxp636Yc33ZRWe4mKu
         T7W1bfyJpV/seJhH1uyyvFAu+WBRawvVRSg8X2HLg00/jnDtS8SdXdeD8f4nXbGXW0iJ
         2fX0R0705sN2vZNAEadGjFkCKUCb9rmwmBR5HuWvr8v/OwJ0Nbhufx2NNLtCh5/ukTU/
         7beMQQMoKUEF2PjpwPJmNX/elScjGN3wZVb89wJuX1LfvaJpevExXUqupZGIz7TzA/ks
         GOFZCEWEYQqctKfChq8QDxBRLbRoUyZmyhsyWOL0egxKPZmxMQk6CfuMbR4VuYiIK936
         sCKw==
X-Gm-Message-State: AGi0PuaN3dnnC3gHzYfU3kbT3ZvSV8bmS7GmHVsdyvjNDheeKsMiD3ly
        XZNOAVdCOoAPHrjW6v//0mIEgGWmNqk8
X-Google-Smtp-Source: APiQypLB65S/PY8B9J4Ak4AjFaL6BtHHrEGN5CiJKb6wEcLe1MP6P9YJq9uKtc2TkitLx67ssJ4fzAnwnYGA
X-Received: by 2002:a1f:d841:: with SMTP id p62mr6499884vkg.13.1585550564486;
 Sun, 29 Mar 2020 23:42:44 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:42:30 +0200
In-Reply-To: <20200327100801.161671-1-courbet@google.com>
Message-Id: <20200330064233.74407-1-courbet@google.com>
Mime-Version: 1.0
References: <20200327100801.161671-1-courbet@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v1] powerpc: Make setjmp/longjump signature standard
From:   Clement Courbet <courbet@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Clement Courbet <courbet@google.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks you all for the comments. Everything addressed, plus the array vs
pointer suggestion from Segher Boessenkool on the other thread, which
is only cosmetic and does not change anything wrt behaviour.

