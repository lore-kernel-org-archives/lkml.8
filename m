Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FAD21D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 04:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omvUtMOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgDQE5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 00:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgDQE5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 00:57:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608BC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 21:57:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so751039lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAXLh21D1H+VdzVaEm6UUMdNn6pp4CFR+JZITSbC43A=;
        b=omvUtMObZ4ytZy4ga07liDJn7z889vwFl09t5zHlrYCBSU49S9IkMFuqiBa9d39etu
         KsKWpvl2Cki8Uu9FJKXae1I2yYCBUCOx3AyCTHGEeoS1ix4CgHBdno3vZaqUAXNA0R2B
         AGO/9LMYemZFLFg/pxQGFrL7TJz2koP+sVQBzb9UzeV3F+Etcqqu7tVjIFBPhPmW7d/Z
         N05JLYgt+palNlhbjz4Wf9+lQ78ol/d6WZ5eos9IdYe0iecp28/MsKfb0/lJAwUQZoTP
         HXyeky6W5Flv/7ss9Inw39okRWqUUCnUfmLr5iNWoZ3U6z31XtvM1XlmyLiQAC/OvFeo
         6n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAXLh21D1H+VdzVaEm6UUMdNn6pp4CFR+JZITSbC43A=;
        b=gLPQbTMRpArr1kAxDg54dVsuvGVQD0lEiX/iCNkqXVunB5n2+gWUcHyxsZSaDticiO
         fYXKyxLgnJs3JPmvqGU+7rweN8O4wle8gRzEiABT1XNFTjSHgmO3pmfjsoCKf5bWwqZE
         VDvdWnfNE7qKND7odgn+79jLLcgaTnAuhBL/KHzDyLDfu3L9V0ExdIa84ghZqvYvEixc
         5uN1bSU+W0uv8jPQYgWrIBXYF/M/1ygXQl+hqCEnyJGmWDMJsm8YSjiblayzASo8KBt+
         u70yNzkjufMp6xK1KkZxeR87IBLb22xtGsUcj69Nme4tfBjGOqpTQ0x/yBXujYolMPQF
         n+Dg==
X-Gm-Message-State: AGi0PublHvzFWnPA3W/M++Gkg0tQbJM/RKYhuAIGWsQzZwKfl6vY3q8x
        2I16lVaH49eTgeYqldXbMCo2Yp7JpTtNQtpEspoklA==
X-Google-Smtp-Source: APiQypLUdzsG2tylnYP/76UWnLr0a8aCftlJOk0jhGyINMlUAKjyl7H4IKqA4OZZlwWqjW74t1URhYwOm29xZbRW2S4=
X-Received: by 2002:ac2:5c07:: with SMTP id r7mr840725lfp.160.1587099432900;
 Thu, 16 Apr 2020 21:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585636165-22481-1-git-send-email-sumit.garg@linaro.org> <20200416174617.GI199110@linux.intel.com>
In-Reply-To: <20200416174617.GI199110@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 17 Apr 2020 10:27:01 +0530
Message-ID: <CAFA6WYNJuxGToM1R02RsrZ_xK6Rfi1SndY1oVYaAbizMpeGPbg@mail.gmail.com>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust source
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>, kgoldman@us.ibm.com,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        monty.wiseman@ge.com, Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 23:16, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Mar 31, 2020 at 11:59:25AM +0530, Sumit Garg wrote:
> > Update documentation for Trusted and Encrypted Keys with TEE as a new
> > trust source. Following is brief description of updates:
> >
> > - Add a section to demostrate a list of supported devices along with
> >   their security properties/guarantees.
> > - Add a key generation section.
> > - Updates for usage section including differences specific to a trust
> >   source.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Overally this works for me. Can you bundle this with the code
> changes. Maybe some details needs to be fine tuned but easier
> to look into them in the context of rest of the patches.
>

Sure, I will send next version of complete patch-set.

-Sumit

> /Jarkko
