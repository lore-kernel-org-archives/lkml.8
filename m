Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF3C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B69F20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5+h1gu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCYUV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:21:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41187 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYUV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:21:29 -0400
Received: by mail-io1-f67.google.com with SMTP id y24so3679652ioa.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wcc3fwrS8JnPRZprBTyUdvWc4Xei4mHeogWRJkq6CY=;
        b=I5+h1gu5mhDMyLsqRy+xtMr+jh3nd27e83biTBarZMcqTcDeYgBseua5H+62syFNcz
         nlLeOTcMKcP+UQ2EbWz8mTHCNhnDP8S9ZqOf0YhHJcLvj0NH3V8ewqVrHtdkao934D69
         5oA/ci7plPjM92gm5MPNqF6RpkNkffYZ9AzwOQthDYXjhXl6hUT5ydE4H65F+GjyRpwk
         oZ1W1EFjC8y6ErFvwQHUkdlFoFtHcXD25cothFiX8R+NxsZm+DJf+ZjywXBwd8MlYV1/
         T7MR37EFQzOM2GejOS/cBQj/WDlNZ+pHCHsvSuFH44inNY2/K8Aded6YdR1TnkaEH2Y8
         3f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wcc3fwrS8JnPRZprBTyUdvWc4Xei4mHeogWRJkq6CY=;
        b=t4vBWU63MzwxzSqu0kZDcLiQutQcBAtVFoc64n9SAqZ9F+0qhHPZ1CGjJURoJQFAkm
         egYBWNKNG2cUC17XPHX5xiyQXJzR2Ko3S4vpGyIDxYZKHcQAVLO2uQv7Z7+Wfet+bXhF
         ndDnKBtjM05ttdoyVzBXd08E9G2Tzh9zf75IU/lKs369yr/jm0a/Iu70dNjCQXTicIbQ
         rwna6F8a1Zu5oIe525mW2U0jkgrneR5IvwjkNDBePVGEksV8X9iiEOVAu75ULz553+eO
         1tKKhG0mHQBZq/vjcIayA8KMg/p3F7ve871WEAexYokDJmAoPeb+JcB+1gFORe+/XeMy
         dL+Q==
X-Gm-Message-State: ANhLgQ2JxkxpHOJGAYh7NETwIZWX+PHZfdKlNoixr70cXbPvSA6P9hN5
        j5M/D+DBH57a3LCjZNIfCSvqAJGYjP0h9/pAdzw5BQ==
X-Google-Smtp-Source: ADFU+vtJ+fOxLlnspbtL6pwbALF1L9KsGYInL+DB8gtfBgoir8Bj2Q75/B8f/uXkeHCMuhDUMX/RYJB09K2CK7Sutxc=
X-Received: by 2002:a5e:c803:: with SMTP id y3mr4608774iol.82.1585167686234;
 Wed, 25 Mar 2020 13:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200325194317.526492-1-ross.philipson@oracle.com> <20200325194317.526492-11-ross.philipson@oracle.com>
In-Reply-To: <20200325194317.526492-11-ross.philipson@oracle.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 25 Mar 2020 13:21:14 -0700
Message-ID: <CACdnJuvkrMCbOwqkWUOZunXmu1AwfRpjNp3OAfqR2y0O+OK5Fw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/12] x86: Secure Launch adding event log securityfs
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The late init functionality registers securityfs nodes to allow fetching
> of and writing events to the late launch TPM log.

Is there a reason we would want this exposed separately from the
regular event log, rather than just appending it there?

> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
> +                               size_t datalen, loff_t *ppos)
> +{

What's expected to be writing to this?
