Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F15C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2427C20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="haKqXX/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgFCLvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgFCLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:51:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F01C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:51:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b27so1761515qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=p3JkaxTmMlZLLkeQQN6ZFxzpqnMYEmIMbzLG9f6v4/M=;
        b=haKqXX/i+YsukbXMZduXbqPo+wBKycl/Mi30C7aBDdi599sSY0v0Rz8Lf/CilruOa0
         D6KRRNztwatGP+TopP8TqKiICqVzPeeCy7xgU9Oq7o3q5qEvyoXycv9IMM2jtwDRl8Aw
         gAk6uoRtvarwcd0l4B6ybqjQ2KXDBp9iibjH6CF7G218cpEYX0To/4kS+lHCm+KyZbaG
         NNNlLkwd65xH1qZYVS4ISg826m/Kh99hT+aIR04dlRJkhLidZOyzEGe4kM4SgnIqcHxL
         SQRuo6N88H7NYZlHswxVpRgyAfXeLPoOOzkeXUuZqD/+8GhJBzkFvfuyhi3xc+ISWz1V
         W5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=p3JkaxTmMlZLLkeQQN6ZFxzpqnMYEmIMbzLG9f6v4/M=;
        b=GgUdqJVSwhYOcilHdT5aZNCaeV7X+5cMiMAK99kofYareyeKJJDN2g2Qj5yHzArc3E
         kexOAvt5mdgwsOn+8pmNXyeJu5komO10ipjhoLDuA9JdZGaX1R4tpCq7Z9X93WDUEmPG
         B22PsuKLxt3aYmZqDgVMxkUbeUh/7uneSQ881emmGT9xfUtXKcBjnmrSBYhfl8VuST2w
         fzjziC5uPI8AJkTJTJgWU16f1ir+kYPljg7twpHzAhjVDlUnjgeZoeHgpEphmD26Yp8P
         SjWs+ybL89I6djrHuVw5xnsxu08PbD7Eq+CKTh/pXhXm6FJ4/p251X0ybkWHSBYxuJwK
         qtOQ==
X-Gm-Message-State: AOAM533rm2i8BvLN/IZgymabIUCtgsBYQephcMus1eHXidwzFtPgq2dx
        z5+aL8mqNACwOw8V8yj5QRR9nQ==
X-Google-Smtp-Source: ABdhPJwk/SmqAG3iXoZQtpd8HUJHu650VSPi72o1ZPzZwxWg5ZRcHkkTSKs7KEzQXYPpOPGI59thfw==
X-Received: by 2002:a37:61d6:: with SMTP id v205mr27176221qkb.447.1591185098571;
        Wed, 03 Jun 2020 04:51:38 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i71sm1325426qke.75.2020.06.03.04.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 04:51:37 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for vm_committed_as underflow check
Date:   Wed, 3 Jun 2020 07:51:37 -0400
Message-Id: <B26ADCE5-796F-46C6-8445-2D877B881B58@lca.pw>
References: <20200603094804.GB89848@shbuild999.sh.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>
In-Reply-To: <20200603094804.GB89848@shbuild999.sh.intel.com>
To:     Feng Tang <feng.tang@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 3, 2020, at 5:48 AM, Feng Tang <feng.tang@intel.com> wrote:
>=20
> This check was added by 82f71ae4a2b8 ("mm: catch memory commitment underfl=
ow")
> in 2014 to have a safety check for issues which have been fixed.
> And there has been few report caught by it, as described in its
> commit log:
>=20
> : This shouldn't happen any more - the previous two patches fixed
> : the committed_as underflow issues.
>=20
> But it was really found by Qian Cai when he used the LTP memory
> stress suite to test a RFC patchset, which tries to improve scalability
> of per-cpu counter 'vm_committed_as', by chosing a bigger 'batch' number
> for loose overcommit policies (OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS),
> while keeping current number for OVERCOMMIT_NEVER.
>=20
> With that patchset, when system firstly uses a loose policy, the
> 'vm_committed_as' count could be a big negative value, as its big 'batch'
> number allows a big deviation, then when the policy is changed to
> OVERCOMMIT_NEVER, the 'batch' will be decreased to a much smaller value,
> thus hits this WARN check.
>=20
> To mitigate this, one proposed solution is to queue work on all online
> CPUs to do a local sync for 'vm_committed_as' when changing policy to
> OVERCOMMIT_NEVER, plus some global syncing to garante the case won't
> be hit.
>=20
> But this solution is costy and slow, given this check hasn't shown real
> trouble or benefit, simply drop it from one hot path of MM. And perf
> stats does show some tiny saving for removing it.

The text looks more reasonable than the previous one.

Reviewed-by: Qian Cai <cai@lca.pw>=
