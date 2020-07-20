Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D4F207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjd6AuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGTBnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTBnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:43:05 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549C5C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:43:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h13so10991310otr.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/V56vpG6VmCA46P7nYwbFvH9ch6Jbn81Eu33ezKH4EQ=;
        b=lBjd6AuIheNnitCvLHRoWZ2oDqbEwOMjIx+QaJMcGw6X0fBlzO8TUsb9YNZJmWi0qe
         WhFmGOdgOj0RDBHIg69RfwnvOAjoOFMIVmGOdiPS/wo5GKMfoh7MgRopanvbxvSVkVgN
         lEw/WIITspqQd9FW7KwnuUFVoxyBh/4B3wZ4VgwPJQKpqsz5mE5HPW0hKlYaPVHwA81F
         9xP4IPmxaEfWrVs8bruRr4kQkx9LcNla/scNRe4eVtu4panA3FQ//eYdpi/rMZ8i7ksK
         815vh4RaKZsJpbg1eWLwgTHGrYkVdfSwUsIA5MKvcGpNRHvGf2vCZBUOxFv1xDSj+d2u
         uwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/V56vpG6VmCA46P7nYwbFvH9ch6Jbn81Eu33ezKH4EQ=;
        b=Gct4FSVfZ0DqeyevpkvFyjAuIR7E3SnScgWdDoGOesty+f9DhJrI0o7RTu3maC+z2w
         VzpGI39n6+0dyxtGytgL86SnQOcWRGMhgeJotAQjqxoUdHPKZ6VaUC9exa4G+1sg5jJK
         zmKHqfKdlYX84JPjN2X403BzD7dAwWQKDmAx0Tkza1g+WimRGKnKILqDUiUVz79J6Qan
         oZ+9UynKhCdU1HatHaiwgogE8VxBppYqrQ4OI3j1dZQr6N486BTs3qYQ1dpZ1aFb+fMG
         NwYY+UXC/Hcl5Fkz/oWgx5BQgrC/kGHCmVBnW+WAwFFwxe8R4Qf9J+EHLziy0egar856
         W/bA==
X-Gm-Message-State: AOAM530gL4dsP/C9X0Qv/5B+vKAwxylI+//KPihCBhMJyyygIwjKGdgy
        HW3WvEYrox9CJpCQsdPUxED710ro0oz1YhSZLi0=
X-Google-Smtp-Source: ABdhPJz0T2XPbt6RJEE+xqKozWMd00jTLrYdaAnuVRYhHFryyIp8su5E3iKVJSzCuUeSsae1swlIbST9HW09gA1o24c=
X-Received: by 2002:a9d:6a12:: with SMTP id g18mr19272580otn.155.1595209384681;
 Sun, 19 Jul 2020 18:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com> <20200717040958.70561-7-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-7-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Mon, 20 Jul 2020 11:39:49 +1000
Message-ID: <CACzsE9oEB7Gs5bMatvoOs66vFkaFEBwJvj_nhBg2P8zVH8maaQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] powerpc/watchpoint: Set CPU_FTR_DAWR1 based on
 pa-features bit
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:10 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> As per the PAPR, bit 0 of byte 64 in pa-features property indicates
> availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
> DAWR is present, otherwise not. Host generally uses "cpu-features",
> which masks "pa-features". But "cpu-features" are still not used for
> guests and thus this change is mostly applicable for guests only.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
I checked those PAPR values are correct and checked running a powernv
kernel in p10 mambo with dt_cpu_ftrs=off and it does set the
CPU_FTR_DAWR1 bit.
(using p10 skiboot).
Tested-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/kernel/prom.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 9cc49f265c86..c76c09b97bc8 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -175,6 +175,8 @@ static struct ibm_pa_feature {
>          */
>         { .pabyte = 22, .pabit = 0, .cpu_features = CPU_FTR_TM_COMP,
>           .cpu_user_ftrs2 = PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_HTM_NOSC_COMP },
> +
> +       { .pabyte = 64, .pabit = 0, .cpu_features = CPU_FTR_DAWR1 },
>  };
>
>  static void __init scan_features(unsigned long node, const unsigned char *ftrs,
> --
> 2.26.2
>
