Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B7C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331520787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh5NyyG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCSNfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:35:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39199 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgCSNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:35:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so1441581pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ket5nG48OjRkSmjRLhm6o/GZWaiXnw2ieKQdmnyTlMc=;
        b=Bh5NyyG1M8gtKQIPrZf/5qLuu0ztHrg/ar6jVL2/WT1taChSOWg/KvzKJbbR0KSYtR
         XPtaZguXMqGkXBJ3gJyLO7wN+gVjLuV9q3Tz8TwQGSGAjkytzkvd45orPduurhypW4gD
         yJO04p/sjDB3DsSwi3caCRbP2G4wKsjv3RFhMMrqRyLk1I17Hd7iKJTiXBdaQKPXCmbG
         /NP1TWBrM/8HPRvMvfpqj8Jq2nmMrWRYtiIF3ldTvwMzZPlyYJxZwNVJiKpxUepjxUOW
         3Rs27tmyLu3uAw+5+1836CWrZplMOz3sKM7WD7zh+xZEVScIfOCeygBpVOiyZhii8JwD
         BWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ket5nG48OjRkSmjRLhm6o/GZWaiXnw2ieKQdmnyTlMc=;
        b=CKTeargNKD5IwJ5jnXtWN8AbXNXw/aefnb0QnfvofwZFj1CoVrC+5IaSTbuG5Cgx6W
         a7YDTbLe1XamtiXG6540TVMldKMIZaMVfG2Vi3ed8THGrjCH7AiEqHBeNaUAGu+W9Zrw
         gS7aqScBUIhg2M1ppySat07kM3z/zZ6/2CSyHKQwDyij6Z6qSx6cc5CgDTWkWUW/LU6J
         xO+Hu0yG9iwGPqQrucwHFIO5v7TxJnlYIQFZwf+19IdGdjSws7mfIueH8CXYOUm+UOgW
         uEPEpr7yy6lWXQCXWA0XOGUm/0XUtlhPU+8NI6NArNSpfZ02AIyCa69umQyQlNwbwoHU
         BrKA==
X-Gm-Message-State: ANhLgQ0h5sL1PyeQVOzw6ATyOTbC/jxbxBpXJ4CAWXyquk783h0ToE3y
        q+K889i0WCCzbimjsIaSj8EaVOExT9grixMzBYM=
X-Google-Smtp-Source: ADFU+vvo67RB7PN+1WI5QYtP3PGnTDjr7aFXa63C0L5Ako2i2oQmzaEBTO0AggKTr2A7JzPp7zlA8WyDdxJDa+KRnLs=
X-Received: by 2002:a63:1c4d:: with SMTP id c13mr3369187pgm.4.1584624911491;
 Thu, 19 Mar 2020 06:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584613649.git.msuchanek@suse.de> <1b612025371bb9f2bcce72c700c809ae29e57392.1584613649.git.msuchanek@suse.de>
In-Reply-To: <1b612025371bb9f2bcce72c700c809ae29e57392.1584613649.git.msuchanek@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Mar 2020 15:35:03 +0200
Message-ID: <CAHp75VcMkPeJ6exroipnxvf-7g-C8QbVm0bAnp=rk505_nxySw@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] powerpc/perf: consolidate valid_user_sp
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-fsdevel @ vger . kernel . org --in-reply-to=" 
        <20200225173541.1549955-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 1:54 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Merge the 32bit and 64bit version.
>
> Halve the check constants on 32bit.
>
> Use STACK_TOP since it is defined.
>
> Passing is_64 is now redundant since is_32bit_task() is used to
> determine which callchain variant should be used. Use STACK_TOP and
> is_32bit_task() directly.
>
> This removes a page from the valid 32bit area on 64bit:
>  #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
>  #define STACK_TOP_USER32 TASK_SIZE_USER32

...

> +static inline int valid_user_sp(unsigned long sp)
> +{
> +       bool is_64 = !is_32bit_task();
> +
> +       if (!sp || (sp & (is_64 ? 7 : 3)) || sp > STACK_TOP - (is_64 ? 32 : 16))
> +               return 0;
> +       return 1;
> +}

Perhaps better to read

  if (!sp)
    return 0;

  if (is_32bit_task()) {
    if (sp & 0x03)
      return 0;
    if (sp > STACK_TOP - 16)
      return 0;
  } else {
    ...
  }

  return 1;

Other possibility:

  unsigned long align = is_32bit_task() ? 3 : 7;
  unsigned long top = STACK_TOP - (is_32bit_task() ? 16 : 32);

  return !(!sp || (sp & align) || sp > top);

-- 
With Best Regards,
Andy Shevchenko
