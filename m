Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671F0C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20557207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVrK3Sjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgAMOSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:18:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43673 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:18:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so3869661pli.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQeL94PTELycFwT5eMUJMVKrSEzOkD8xeVntj3943mQ=;
        b=VVrK3SjlF7j0WTV4dF9SBqCHbgVj5QaB667uUSiyafMwuG1x/HtG96E/AwvNHLo5U4
         mtY3XZvIwwwfsiP547Fq5meCll4ZGOrjHYlP2gI5u6dvsRGEjbbCSHLeNWuDnrgD1MjK
         Fus+IAwNOnUk8UHhJhPV5G/gvv47CQi9fWXaaqyRtBVN+F3oWIuaY1yBjxX/2bGBqf8X
         ONwUdxvNaCxuj/K6RWhp88gu+H2VISWyuPHBEHOszU7kgs2PYROYsUJLy/Y7MP0UbEtj
         MuSx54MwPA+H8PUuHPHjoewqsi4Z6JhwG41laJRyuz3Gyo87jLLRJOyJ+w991j5/Ohsr
         upeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQeL94PTELycFwT5eMUJMVKrSEzOkD8xeVntj3943mQ=;
        b=F+lnrTruppcPCmy4DLgbKwC8/7CiDUyyYf0Qd0hdKHvIwhcaIT+NGtT1kMj09qIYCB
         AZV6Fz2Q8j6jHuMyJUTZwv2kcuGwIQUyZ8I/Vcpgtl8+Vcv2rdFvaH73g/uh3WV0E37m
         4fr4P7gQBTyt+ALV2cpJB6hbuz0EevJj6uUW1Mqpfs0qaJZMlvQWmsyLDGj9W04WVy4u
         5kRksmQrceeoSIl7HzFGbVY6MnEJCwodTsf9cucNBCxl0v4JK/2BtU/UvQQvDwtP6eQa
         QGiVADnmu2pnw8UBsx2VuP2Noqor5TN7dRohrjRkdTOi5JTLXAJUnnl9zFfP9T+M6fyL
         T8KA==
X-Gm-Message-State: APjAAAUebqDVkrZKUHQUYmXCbtUrFKNv5q0iuS8m9mhZkX9pFn9uFCh6
        vBLdqbI72wfAbJPqm2DZCuwc0w==
X-Google-Smtp-Source: APXvYqxhdHJjwPGyqzrRjZ+F8r7DwqJbKF/VbADsmGxrXQt0n5HhrCV3zw1hi6afzan8Fpw29zonPg==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr22469023pjb.21.1578925079973;
        Mon, 13 Jan 2020 06:17:59 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id z64sm14906784pfz.23.2020.01.13.06.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 06:17:59 -0800 (PST)
Date:   Mon, 13 Jan 2020 22:17:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Message-ID: <20200113141751.GA10620@leoy-ThinkPad-X240s>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Jan 13, 2020 at 12:27:38PM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo,
> 
> On 23/12/2019 03:48, Leo Yan wrote:
> > Hi James,
> > 
> > On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
> > > This patch fixes an issue when non Arm SPE events are specified after an
> > > Arm SPE event. In that case, perf will exit with an error code and not
> > > produce a record file. This is because a loop index is used to store the
> > > location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> > > index will be overwritten. Fix this issue by saving the PMU into a
> > > variable instead of using the index, and also add an error message.
> > > 
> > > Before the fix:
> > >      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> > >      237
> > > 
> > > After the fix:
> > >      ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> > >      ...
> > >      0
> > 
> > Just bring up a question related with PMU event registration.  Let's
> > see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:
> > 
> >           spe-pmu {
> >                   compatible = "arm,statistical-profiling-extension-v1";
> >                   interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> >           };
> > 
> > 
> > Now SPE registers PMU event for every CPU; seem to me, though SPE is an
> 
> Do you mean "SPE PMU" here ? SPE is different from ETM, where the trace
> data is micro-architecture dependent. And thus you cannot mix the trace
> on different CPUs with different micro-archs.

Understood that SPE is micro-architecture dependent.

Usually, we should register PMU event once for the same SPE version and
CPUs can create multiple instances.  My concern at here is the PMU event
is regsitered for multiple times for the same SPE version.  Please
correct me if I misunderstand.

> As such I don't see any issue with this patch.

Regard this patch, it does fix the issue if based on current PMU event
registration; so it's okay for me to merge it if now it's not necessary
to change PMU event registration.

Thanks,
Leo Yan
