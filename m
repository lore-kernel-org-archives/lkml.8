Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF81C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FD220760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LOXuySGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHVpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFHVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:45:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B07C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 14:45:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so20050254ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Igh1IwPinYOHclngfiWXcdsSPSUfVMy900DjvDtZXdE=;
        b=LOXuySGWu6oAFpGSLwRnURotT4T7GHHSY8T9C0/cwfQxalBA7tF1N8cu7f0k4Vd7je
         2No1nZdIXfZBnRgD9v81wSb36UQ5bjRNEbUXERvVtplQxTrxs8dvo4A6Mtj+6t6MuDzi
         ZPhVp9z/CE+pLdK4Zo5eEp5VKji/83r2UQmLRNH/pOJxDdHWL1lEtlYwDBnmwE22ei2e
         VQq4KTiFCLaSadosS5Zvc+cH8vt4rjRvXGRHit6il9pQWF2iKmhaynrEo6pO8pp/HJ+s
         B/pvew9eTKduP1472XSQBRUT6f8V9ztWio0h6GyyWcS+SWRPCE8iWR/zDxiCEZPGa39s
         A/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Igh1IwPinYOHclngfiWXcdsSPSUfVMy900DjvDtZXdE=;
        b=kbph+TCKL/75lGXbk0t66VfNLoEBpJKIKQhntmp21awzxlqj/q5+AaiDsH6EtclBhl
         hxFZo0EpCUcKm1X7ax4Ya2kjjLH1o4Qbqrq7hFgPR3a7MxtBat7wpR8i71QNB7HHLloL
         /aB0Z2M7DfvK8xth4QfaqpOhBcPi5Dydcwfioi3VwCScPbIdKDpNxgvOw5biCemNgABJ
         YFQHtbT20Errx7eDxNaftcjn5kCoCdCvto6jgJbV+sb2JVkZhhnPuz5e5N3VkKJs9aUR
         se7trHyMtV+fS0JgNTjruX7ueeqDXt4v+YJEhfmxXaBkNVN/e9GG7UoHlmZwgMPtLC2b
         HcIA==
X-Gm-Message-State: AOAM530V4w6gDodEfdV2/F5CuxoiZ9+PGVYDts+TIkYe9jtTGrBiWoBK
        g84rH7tODm7S5g/uNI0As9kNAh8EcVjEt9Tq/WVG
X-Google-Smtp-Source: ABdhPJzM1blhuSfAtHWQKHod1napq/wyiCDkQzMZK14COSUGFvoq3xTJ7+bH9cmWhMvSg5A2bYc3wf0KPT0tdU0HpE0=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr21816983ejg.488.1591652716065;
 Mon, 08 Jun 2020 14:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200607221449.2837-1-nramas@linux.microsoft.com> <1591617171.4638.33.camel@linux.ibm.com>
In-Reply-To: <1591617171.4638.33.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Jun 2020 17:45:05 -0400
Message-ID: <CAHC9VhQpK+Shy2b2tv+vrTS+a8+zZbsrRG=pjzoMK0LApJg1Sg@mail.gmail.com>
Subject: Re: [PATCH v2] IMA: Add audit log for failure conditions
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 7:52 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Hi Lakshmi,
>
> On Sun, 2020-06-07 at 15:14 -0700, Lakshmi Ramasubramanian wrote:
> > The final log statement in process_buffer_measurement() for failure
> > condition is at debug level. This does not log the message unless
> > the system log level is raised which would significantly increase
> > the messages in the system log. Change this log message to an audit
> > message for better triaging failures in the function.
> >
> > ima_alloc_key_entry() does not log a message for failure condition.
> > Add an audit message for failure condition in this function.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>
> Audit messages should be at a higher level.  For example,
> "hashing_error", "collect_data", "invalid_pcr".  In the "invalid_pcr"
> case, the audit log contains the reason - "ToMToU" or "open_writers" -
> as to why the measurement list doesn't match the PCR.
>
> Here you would want "measuring_keys", "measuring_boot_cmdline" with
> the reason it failed, not the function name
> "process_buffer_measurement".
>
> Userspace needs to be aware of the new audit messages.  Maybe include
> samples of them in the cover letter.

Yes, examples of the audit record in the commit description (the cover
letter isn't recorded in the git log), are encouraged.

-- 
paul moore
www.paul-moore.com
