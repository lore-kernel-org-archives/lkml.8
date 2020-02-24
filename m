Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50674C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292812080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IjzPlx97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBXTCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:02:44 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42196 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgBXTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:02:44 -0500
Received: by mail-qk1-f182.google.com with SMTP id o28so9634989qkj.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARwFyzz0JExUpMzSO2Lt2xI0FNoiJ+LE4d2sqS22dxo=;
        b=IjzPlx97zEqGWxBDi6GU/OQihwWkUpJNl3TXqHGq5V+33oDTK0QZbDMuuCsnU+g0Hm
         4ZeKrUMtPcp2n5jSF6JrQY6AZeP1YAn12xMb9E1lbjx3NP+UOw0JFOKaN1S30q3X/Pd4
         gofrWSY60fkRjxs4E2he9VK4/10PmJN1HuWNBmCP5tU8bD8ORXZO7Ufn9fjIiGVQN1Rf
         oIHGfN/bd0R+zJJTCQBxdFy6SEC6D4QuTIFT6hBEWsrthj/ZrixO803Jlt0C0CG+ABQk
         dO+HIFViGJ6o8aA8Fkvbp32HLyhiMDeavYSNBTU1azOO5Jcf1cOyQDBwrEqaziXv3uUA
         H1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARwFyzz0JExUpMzSO2Lt2xI0FNoiJ+LE4d2sqS22dxo=;
        b=oJx69qQqOBWoo9HLAi6g7fgwLoBJfDT5RXzMmkIievCZL4M2TDaUBP3WDnzzVdoR06
         okjq0aeQSxdgb/0CaFJylYGb6JOXqJ9K7uIy8LA2dqGbayFrDePa8LWx7Dr9xt6Vxx69
         y0A+seP82tf1dt/+Q+DHWZT95CmasQfC+UqzE1StAoZdMHVMNLGkTC2S/f8cFHBvZvWt
         wqF8oTemjxo9H5A/8/XoPpURqkGJsM9zvNzG9QIZ47mJ44G0udtsTVUYo94YD0PLRTOK
         576Eg/xevYBBNa32+XeZ5IB0zoMDMoNnAxXB5G9M/8fKUunPj71b4EydwgtjbOHAXRFm
         7XaA==
X-Gm-Message-State: APjAAAUjWQJp8RLDvd5jdBJZ15xJzv9p2E7q3P53qF4c2GkeFdNZhBr+
        Xvfgpnx6TuQ+umuDoGNLbE2weQ==
X-Google-Smtp-Source: APXvYqxPyWWKFSBNUVffhHJrBhJGxQCVlVMLJa1LgrQfCcin8bnGiIYRzI+tEnz+HeGNTo0mqYd6EQ==
X-Received: by 2002:a37:a744:: with SMTP id q65mr9424088qke.354.1582570962035;
        Mon, 24 Feb 2020 11:02:42 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t3sm6525471qtc.8.2020.02.24.11.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 11:02:41 -0800 (PST)
Message-ID: <1582570959.7365.116.camel@lca.pw>
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
From:   Qian Cai <cai@lca.pw>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, elver@google.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Feb 2020 14:02:39 -0500
In-Reply-To: <CAJZ5v0jXZOd0yfnwcP1NrfrXnALx=5E1nmK8DHk8bJ0SLUYzAQ@mail.gmail.com>
References: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
         <62491094-D13B-4EED-8190-4AA4EB77036B@lca.pw>
         <CAJZ5v0jXZOd0yfnwcP1NrfrXnALx=5E1nmK8DHk8bJ0SLUYzAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 10:54 +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 24, 2020 at 2:01 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > 
> > 
> > > On Feb 23, 2020, at 7:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > 
> > > It may be a bug under certain conditions, but you don't mention what
> > > conditions they are.  Reporting it as a general bug is not accurate at
> > > the very least.
> > 
> > Could we rule out load tearing, store tearing and reload of global_req in cpuidle_governor_latency() for all compilers and architectures which could introduce logic bugs?
> > 
> >         int global_req = cpu_latency_qos_limit();
> > 
> >         if (device_req > global_req)
> >                 device_req = global_req;
> > 
> > If under register pressure, the compiler might get ride of the tmp variable, i.e.,
> > 
> > If (device_req > cpu_latency_qos_limit())
> > —-> race with the writer.
> >          device_req = cpu_latency_qos_limit();
> 
> Yes, there is a race here with or without the WRITE_ONCE()/READ_ONCE()
> annotations (note that these annotations don't prevent CPUs from
> reordering things, so device_req may be set before global_req
> regardless).
> 
> However, worst-case it may cause an old value to be used and that can
> happen anyway if the entire cpuidle_governor_latency_req() runs
> between the curr_value update and pm_qos_set_value() in
> pm_qos_update_target(), for example.
> 
> IOW, there is no guarantee that the new value will be used immediately
> after updating a QoS request anyway.
> 
> I agree with adding the annotations (I was considering posting a patch
> doing that myself), but just as a matter of making the intention
> clear.

OK, how about this updated texts?

[PATCH -next] power/qos: annotate a data race in pm_qos_*_value

cpu_latency_constraints.target_value could be accessed concurrently via,

cpu_latency_qos_apply
  pm_qos_update_target
    pm_qos_set_value

cpuidle_governor_latency_req
  cpu_latency_qos_limit
    pm_qos_read_value

The read is outside pm_qos_lock critical section which results in a data race.
However, the worst case is that an old value to be used and that can happen
anyway, so annotate this data race using a pair of READ|WRITE_ONCE().
