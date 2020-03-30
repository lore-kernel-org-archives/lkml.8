Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6554F20776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxhpA2L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgC3RU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:20:58 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44189 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3RU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:20:57 -0400
Received: by mail-pl1-f182.google.com with SMTP id h11so6974762plr.11;
        Mon, 30 Mar 2020 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3yni0Qcm8n05TZCBj3hKRu8NlwE4SJ7yEQomCEGLDwk=;
        b=pxhpA2L10LsUBSIcO30K/eICyF7HWIxFaI9tUeDTf63aY3YXDhdwI7iGYk3Z8c2FoV
         3Cz7NtUP+cgrgbTtT4DjY4cdHgQmrkZ3coJQZlj/V0D7xqz7MqzG1fUYe99AW71DI8zr
         9raQIzS5GzOIAajfVqp8v+a8C7jylqolpKsmr8DaMnA4a2Temw4YOJ8dGKtC0HTvBGjC
         N8NfMHzcA2iCnb8Xoynpa/rwuMGdgp+FpgOAgJiVRQOdxEHjDTa6z8CJuUifB41/nMQ/
         AUgrGiXPeqoWBDiVavraPnqcBX8k//OPulwAYNAk0gXUK0nmI2RfMEBirWr5VhWMmeAr
         vavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3yni0Qcm8n05TZCBj3hKRu8NlwE4SJ7yEQomCEGLDwk=;
        b=tQj9o9Rzi3V2S//VJMET1ABcSQHajL/ccccN3q019TH5tsKxiQCxRY152/vqb3iWZz
         iF9Vt9UAx12f4KKXJk6mNfIVQvkiHYTiir5J0Ml13moOz7/tC3vDUl42gIwWseeh6/Pp
         Kjkw7qdTB0lhCPcmCQJWY7HQBeGssIYPtaLGozHeJZpWDP+xAdnnFz3WBedbOK4pBPHz
         VAK/41bhgdfsGchV5RvJfT7HOYTUlhWaMhvQvLWzkYWuoeCg7DpYOg059rVSMRv9Ke7r
         +QWaESC6cpzbH73qVQqJ0/zM+SsOlsusJxAIzOxEogG7KL2RMjDnhNihLY4f7BFIS5iS
         J7Ng==
X-Gm-Message-State: AGi0PuZVI33MQRykpLLQWoB25T9NT0l++sbcO3ddhXWeD+lOzBBaIMjm
        piDIPg36WmIITKl5LWmXoQ==
X-Google-Smtp-Source: APiQypJBb2i9rRwC+yOX3INiEusu9vUs5TtTTrS58fzbolGuSNQ3GmogcrkN3O4Rl9gKdoiuIxZ1JA==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr4216084plt.223.1585588856352;
        Mon, 30 Mar 2020 10:20:56 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:d3b:3d6b:7942:93fd:fd15:96f0])
        by smtp.gmail.com with ESMTPSA id s61sm96571pjd.33.2020.03.30.10.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 10:20:55 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Mon, 30 Mar 2020 22:50:48 +0530
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     madhuparnabhowmik10@gmail.com, gregkh@linuxfoundation.org,
        hariprasad.kelam@gmail.com, colin.king@canonical.com,
        tony.olech@elandigitalsystems.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru
Subject: Re: Possible data-race related bug in u132_hcd module.
Message-ID: <20200330172048.GA12976@madhuparna-HP-Notebook>
References: <20200330115243.11107-1-madhuparnabhowmik10@gmail.com>
 <Pine.LNX.4.44L0.2003301159170.12110-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.2003301159170.12110-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:03:31PM -0400, Alan Stern wrote:
> On Mon, 30 Mar 2020 madhuparnabhowmik10@gmail.com wrote:
> 
> > Hi,
> > 
> > This bug is found by  Linux Driver Verification project (linuxtesting.org).
> > 
> > The bug is related to the parallel execution of u132_probe() function
> > and u132_hcd_exit() function in u132_hcd.c. In case the module is
> > unloaded when the probe function is executing there can be data race
> > as the mutex lock u132_module_lock is not used properly. 
> 
> Normally drivers do not have to worry about races between their probe 
> and exit routines.  The exit routine should unregister the driver from 
> its bus subsystem, and unregistration is supposed to wait until all 
> probe and remove functions have finished executing.
> 
> > i) Usage of mutex lock only when writing into the u132_exiting
> > variable in u132_hcd_exit(). The lock is not used when this variable
> > is read in u132_probe().
> 
> I'm not familiar with u132_hcd, but the probe routine shouldn't need to 
> use and "exiting" variable at all.
>
Even I am not sure why it should use this variable to check, that's why
I thought of asking in the mailing list. If the maintainers agree that
we can remove this variable I can send a patch doing it. This variable
is not used for any other purpose in the module, so removing it
shouldn't be a problem.
> > 
> > Moreover, this variable does not serve its purpose, as even if
> > locking is used while the u132_exiting variable is read in probe(),
> > the function may still miss that exit function is executing if it
> > acquires the mutex before exit() function does.
> > 
> > How to fix this?
> 
> Are you certain there really is a problem?
> 
If the variable u132_exiting is really used for the purpose of checking
if the module is exiting then there might be a problem. If at all it is
assumed that exit never races with probe function and it is always
called after probe finishes or something, then this variable is not even
required. And suppose there is possibility of a race condition then only
holding the mutex in exit but not probe does not make sense.

> > ii) Usage of mutex while adding entries in u132_static_list in probe
> > function but not in exit function while unregistering.
> > This should be easy to fix by holding the mutex in the exit function as well.
> 
> Why does the driver need a static list?
>
I do not know much about this module so I cannot answer this.
From the point of synchronization, this list is initialized in init and
then only used in probe and exit function. And lock is only held in
probe, if at all it is assumed that exit cannot race with probe, there
is no need to use the mutex.

> > There can be other synchronization problems related to the usage of
> > u132_module_lock in this module, I have only spotted these so far.
> 
> You should look at other drivers for comparison.  They don't have to 
> face this kind of problem.  u132_hcd should be similar to them.
>
Yes, I checked out a few others and I could not see any usage of such
variable to check if module is exiting.

Thank you,
Madhuparna

> Alan Stern
> 
> 
