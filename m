Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C89C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34942077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnJxDETT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgFETku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgFETkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:40:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADFC08C5C2;
        Fri,  5 Jun 2020 12:40:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so934642plo.12;
        Fri, 05 Jun 2020 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XD9SvQZCXqBYsn01rJ4+6okeD2WJfdjImO5gHn5OfAs=;
        b=bnJxDETTne1L69aD8HMa3+kqe0sCzIsfxsY/YGV+blK3BmwxALlVA3u7SAzSgUmOnl
         Z6vkaXeq1Oll41yzGDjLdhJrjYykohJ9ZMVm+8VJp0451xMrw2obIW8B2NJ81JC9UN43
         eOpQFIYIHQF3Yq7Eh2EfJZjwrtAN20rvfknSbj69OMBiMyO+vYv5t8et8k/frbSnKym1
         jsPzZ9m2bhn9aBApE58LENVDX+Zwt3H5Z87CV5kPJZs6oqAPNJTx8XZoa//yWYIIyKpC
         rbIlTj4JXsNRWc7BjOhLFA3/i09wwxHjH/kdv+KAdrs6i6oon9gYXXYxgg1T1BsmFC6B
         5UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XD9SvQZCXqBYsn01rJ4+6okeD2WJfdjImO5gHn5OfAs=;
        b=SoUyl28PU2DKb6Y12jEFbpaxM9OB/vt1u1hU67SCooDyJo8nFYlQbLQ0jcBj/E6kFr
         A8FKOvVU5epw0rA/1PGbCyNCyRgI9p1x/UFWgJJmrrDEqcpynt2QuPLz9WdCUwXt5TjK
         ZtisQ5vmPjuyaSGM7JJ+jvLcxKejhNNL7K1L5MyOsoY6QAnae2Tnl52QnruiZ2TsKpCm
         suBnfQjq8qaD5wNwvwSxP/MNfzDoo9c0flObwwNbkTwcyhCXYBRB+rgGIy8BYFuX7lcF
         /uIuukoolGx1xJECeTvsm2d9uO6qc+g5rSLj/M10dCrPMcYaFsYG63gL7zXDTiOgoPHH
         jMBA==
X-Gm-Message-State: AOAM531fy9YWyz8pRgpmbdsz7MQxLJ03bs9firWO0e6wy+dwV3vO9uZS
        YhTWiyf17p7wEKbEN7SAFNClHan6D4wCoBZuwf0=
X-Google-Smtp-Source: ABdhPJzxhdZq+OzZcXHaxB72UvfeXpj8EszRzS+I9vY2btE/7JjVwZ1hJGP0sRNO0nUDIIdnYcwulI8NIwFOPnICVV8=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr4668507pjd.181.1591386048635;
 Fri, 05 Jun 2020 12:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2643462.teTRrieJB7@kreacher>
In-Reply-To: <2643462.teTRrieJB7@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 22:40:36 +0300
Message-ID: <CAHp75Ve8A373Cbw6RiKTtkhj9jsxZ9dBY8ELtntk0B=yXxOCUg@mail.gmail.com>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 5:11 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

...

> +       if (!refcount) {
> +               write_lock_irq(&acpi_ioremaps_list_lock);
> +
> +               list_del(&map->list);
> +
> +               write_unlock_irq(&acpi_ioremaps_list_lock);
> +       }
>         return refcount;

It seems we can decrease indentation level at the same time:

  if (refcount)
    return refcount;

 ...
 return 0;

-- 
With Best Regards,
Andy Shevchenko
