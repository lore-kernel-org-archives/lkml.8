Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC63C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D1320709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFu9ELsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEOAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgEOAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:00:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE3C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 17:00:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i5so765362qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 17:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=wKnP4cRDwV5pisveNqypr4DPC2I8ojFUWdJ2DYvbn+s=;
        b=fFu9ELsMYEGcxZpGuSbxGZ5BhePy8a4gaFOp/1xFDw22VuQQ9hU73GRZaeoVCzX9EN
         69pqPdn/N0gZmRsUpxGKx6E35AmCwnb869I6uvf9KIZ7Jo3PcMtRPDk5tSb4RZVOgaxs
         7/AsJfkG9my8BEBrUp5rMnHJaGgxSyVxK9VUjXu7XuRc8yliTk3iFR+m+gaaNTvbqgsw
         +unSpk4sF0Tv+u1e1LTp6O6Whkz0ZrTrgncSheaLDLYKW9y85JjkmsNpUvQiBWNREqW0
         PARvxwirZ6IRnkX877H14Fxgx7hYyuOnn45UXNLduOebj5/4rWkL+l1ep03TTvQiX1/v
         qIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=wKnP4cRDwV5pisveNqypr4DPC2I8ojFUWdJ2DYvbn+s=;
        b=HqKl3qxikiyGjuX8L3ADbZ2TDZuTt32Tm49+GDKIjTj/XUc8rDLlg62al5CWA/wD9k
         /yq1YvyQ4dVDIqZEyOAsfCPlrgzg1wSskhvdqOeS06tLwGnvBihrnRLWWCKc6bvs91CA
         CE/MLwHqJ/avDCXPa6cIrKjs0GiZyZ/cBbmodxD15V1h7bxnzMwKNwOYeRn75J+uAvjG
         twzdghMi6i5L7JXCOIgchs/oOWITGcuvh5U9WUPM0BydzZDIYXUOmCrehrm3NREmDENj
         GuHV55OTQZyqiB8TCbJJvkewqZbL43CRq0viMxKPU7pFPErEUxfZKsBLeCtnG5Re11Fb
         zJDQ==
X-Gm-Message-State: AOAM531AGhlVy6MgaCv1BPkDlWx64kaCnbYVDqeA8IKAG+xDFxCtoZEP
        Ye2RpGr4oNVcbsvU4kaTgSc=
X-Google-Smtp-Source: ABdhPJxzlVVZEyGno1YM1Z74EjtIzkmN8CMMFZ3IbQ1B4TaEKsA5p63EFbGw0iIYxgkADVp1jJ1hgg==
X-Received: by 2002:a37:a1c7:: with SMTP id k190mr826162qke.469.1589500841967;
        Thu, 14 May 2020 17:00:41 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id c25sm330412qkm.119.2020.05.14.17.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 17:00:41 -0700 (PDT)
Message-ID: <344838598649fd638c9408606efe8db4c69db9cb.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/rtas: Implement reentrant rtas call
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Date:   Thu, 14 May 2020 21:00:29 -0300
In-Reply-To: <fc13b26ff3d2ea2e84049eabda0c60a60d851b40.camel@gmail.com>
References: <20200514011245.127174-1-leobras.c@gmail.com>
         <20200514011245.127174-3-leobras.c@gmail.com>
         <878shu2vjp.fsf@linux.ibm.com>
         <fc13b26ff3d2ea2e84049eabda0c60a60d851b40.camel@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-14 at 20:28 -0300, Leonardo Bras wrote:
> Yes, you are right.
> I will also add preempt_{dis,en}able, which in most kernels will
> compile out, but it will be kind of 'ready' if we ever decide to
> support PREEMPT.
> 
> Thanks for the feedback!

v4:
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200514235138.150722-3-leobras.c@gmail.com/

