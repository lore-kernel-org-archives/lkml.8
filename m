Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13257C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD619214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+V2QJhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392451AbgDOBSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392448AbgDOBSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:18:24 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408FFC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:18:23 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b13so1810245oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1l2/pt2vcXJs4JHOfaqDncBBzdHatpYCeFPNCdgXmY=;
        b=B+V2QJhLQsBm/e5lZ06FfL9w72jKW1Ok92LzH6+jMc/K7B3adM/3jfrxAccX7mEHh/
         viSNMwIytJNitnDOPAGcYsDZ6hg1F1B2KRhSZad2SqUfaZAKtNSEHMr/KqZntR31eW9b
         mnqU+JLn3CH43CYPUI/cvfgs7CxJv9F/MIgF7y/BSBRwSs+gOOq6SNbqr2GveCzOkz5p
         CUScmSV7n51+5Onkqn/h6yrEICD/toxBejyWTEtaTdAfPvPPnMW8YO5SMzRY12wbQNpq
         qrdse3QF/S6pP6v4PWXI6zy50Cg+YLM4nPIGu9iSofBzsZtwerlh6l/kv037LJENL7pz
         wYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1l2/pt2vcXJs4JHOfaqDncBBzdHatpYCeFPNCdgXmY=;
        b=kEynsth2VEHaEOrQoU+KjxygXnGvHB1hSjzsvFzlYgdFwTt/gWvEy2W801inbdflvm
         wFr3bb3Ybi0CdPt+budm4B5kKNeAj4YqBXoTMkOzzvoBfVB5KbBYMPM8P0erXqpjxf6F
         pxgjUGBAEgvQoBM2elPAtimCAyRHylhMzKOloNDg+B0las3lEl/7RVChnQbUIhQirM7F
         GOeU45/OLL3J2fS0CJIAI4BHlATa7u4/yKe0MEMZnqLlITj9OJS/cuy1f07f2OT+kN3z
         s28uHI1LOQ8U4SyfOZph1Q7s+C9HnI3pkYzoN+XxhlQfW5X0IVLWIHgA5tgaXy8KTPHa
         kfSg==
X-Gm-Message-State: AGi0PuYUNqrPiessrDhooR5DtxqYRz1h+ff9hVB5P6l6+gdud8i5gcZs
        EcSZa0WnaaNDs/Qt6xQ1MpP0YnnnxQrbyhf+oQXELw==
X-Google-Smtp-Source: APiQypK9nKDX/Fv38V2E+Fpv1Q1bTceAzMb90oayw7n7ZzkqoIHvTjqwdd5FRXUJe5CujZpV+QwZrLgaUvSjidfYTdQ=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr11026479otb.352.1586913502446;
 Tue, 14 Apr 2020 18:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200415104152.4d770116@canb.auug.org.au>
In-Reply-To: <20200415104152.4d770116@canb.auug.org.au>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 14 Apr 2020 18:18:11 -0700
Message-ID: <CALAqxLVN_MZ7XWsg99dhy1=Vde_XSCHey78mrxRuu7a_THxYYw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:41 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the qcom tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/soc/qcom/rpmh-rsc.c: In function '__tcs_buffer_write':
> drivers/soc/qcom/rpmh-rsc.c:484:3: error: implicit declaration of function 'trace_rpmh_send_msg_rcuidle'; did you mean 'trace_rpmh_send_msg_enabled'? [-Werror=implicit-function-declaration]
>   484 |   trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |   trace_rpmh_send_msg_enabled
> cc1: some warnings being treated as errors
>
> I don't know why this error only started happening today.  However
> reverting commit
>
>   1d3c6f86fd3f ("soc: qcom: rpmh: Allow RPMH driver to be loaded as a module")
>
> fixes the build, so I have done that for today.


Ah. I'm guessing the newly added rpmh-rsc code depends on rpmh being built in.

I'll take a look at it.

thanks
-john
