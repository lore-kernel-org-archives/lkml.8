Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0961C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9768E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0a14mZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCZXTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:19:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44737 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgCZXTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:19:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id v134so7171169oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyEvk8/M51KdB0k3RzKZQ+MYI/+9ypxdlmp1SmMW2Ys=;
        b=k0a14mZgV+qsmJefk5FW0WRpIXFp3Y2EY5YAXRsG57WFGA+UdtZN7wHpop1fJtXTMI
         6/tMIZ/jAGytCf64CNKgJUw78FNtPwoQqbB7Tuq08ARRQkVN6ZboVhRQWbLF19iwUVWh
         zobNxHzENu4otHX5v99SiEu0jD11Qm7SIKIzbIE83xBD9fvW7cnZ2T+JJwkY7LLzoaoe
         Gd7fpjSgUlpLzzZotvx8jLvoPPu2HNpcEQhd4dUDCYAD7hasysOUJDBDus1bZWfK6XnY
         k9fAuO5LJM5zHkC7z4TqspyMbuhlFhKeauoWfHRh/SLU+Rro9R3Bx60u38w2UeH3OzLi
         fFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyEvk8/M51KdB0k3RzKZQ+MYI/+9ypxdlmp1SmMW2Ys=;
        b=UTUpQgLTswl7IPNQ0Osr7+1ZP+dS55XqgTjrCFShtEC2ZuIWk3mdzW0JrTXF0z1Jbc
         9ax4b0DP3/vm26M+fKV6FxJRVb2zEqmkS8OVU60ID2GonQUoZf+PrM2nP0gBc3eeRJlW
         ZC8XRWDrLS5sjWV7rKowwEvs7cNefH8yr3jLrfpUtL8b1QVGeIq+NswwjFmnEygBmDXB
         WDoguN8mg5zfUohVaZ2BUp2gE9N0+IkBHeNnT+4AcwUTmfzYKqpMjOCjQd7FOdRwkdU0
         sSdL5f+lJxPXu2Nb4Eu1ZDE9UI0yYfynIdGFdBy8kFlhxeT77l6Cbig7dE39G7Y/eAMW
         e5hQ==
X-Gm-Message-State: ANhLgQ3BX1UMv0BdFQLKCjt7hKhJzbhaDZCCdhGzlfaOo0aePOmXy0bH
        FFW4aW5vw4Lcg+4kWdlh7vK27VQJA0+hUE3SQSK7kg==
X-Google-Smtp-Source: ADFU+vsY8jjGNXiVRkPBLoE+CsoFXHwivXDHyvQUE2PxawFxjxYVp25D+Qgv+5hGqwQU/PsArkHMMzI8xKPxOHDQXVg=
X-Received: by 2002:aca:682:: with SMTP id 124mr2145796oig.69.1585264763192;
 Thu, 26 Mar 2020 16:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200326224459.105170-1-john.stultz@linaro.org>
In-Reply-To: <20200326224459.105170-1-john.stultz@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 16:18:47 -0700
Message-ID: <CAGETcx-YynYi803j+O+vBmKNd=xVMX+OSwytOGYu9pURDzg8Zw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Allow for rpmpd/rpmh/rpmhpd drivers to be loaded
 as permenent modules
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 3:45 PM John Stultz <john.stultz@linaro.org> wrote:
>
> This series simply allows the qcom rpmpd, rpmh and rpmhpd
> drivers to be configured and loaded as permement modules.
>
> This means the modules can be loaded, but not unloaded.
>
> While maybe not ideal, this is an improvement over requiring the
> drivers to be built in.
>
> Feedback on this series would be welcome!
>
> thanks
> -john
>
> New in v3:
> * Added similar change to rpmh and rpmhpd drivers.
>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
>
> John Stultz (3):
>   soc: qcom: rpmpd: Allow RPMPD driver to be loaded as a module
>   soc: qcom: rpmh: Allow RPMH driver to be loaded as a module
>   soc: qcom: rpmhpd: Allow RPMHPD driver to be loaded as a module
>
>  drivers/soc/qcom/Kconfig    | 8 ++++----
>  drivers/soc/qcom/rpmh-rsc.c | 6 ++++++
>  drivers/soc/qcom/rpmhpd.c   | 5 +++++
>  drivers/soc/qcom/rpmpd.c    | 6 ++++++
>  4 files changed, 21 insertions(+), 4 deletions(-)

The whole series looks ok to me.
Acked-by: Saravana Kannan <saravanak@google.com>
for the whole series.

-Saravana
