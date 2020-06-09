Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D332074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgFIRhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:37:13 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:44426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728848AbgFIRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:37:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 61C6A10051150;
        Tue,  9 Jun 2020 17:37:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waves38_2c1561926dc4
X-Filterd-Recvd-Size: 1835
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 17:37:11 +0000 (UTC)
Message-ID: <64758b6f2142a1b2a170de38b80f2dbe6c70ceb2.camel@perches.com>
Subject: Re: [PATCH 1/1] tty: fix spelling mistake
From:   Joe Perches <joe@perches.com>
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 10:37:01 -0700
In-Reply-To: <20200609160249.31329-1-f.suligoi@asem.it>
References: <20200609160249.31329-1-f.suligoi@asem.it>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-09 at 18:02 +0200, Flavio Suligoi wrote:
> Fix typo: "tigger" --> "trigger"

Thanks.

fyi:

$ git grep -w -i tigger
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:                       * software tigger (systrig, hrtimer).
drivers/leds/led-triggers.c:/* Simple LED Tigger Interface */
drivers/scsi/mpt3sas/mpt3sas_trigger_diag.h:/* fake firmware event for tigger */
drivers/tty/moxa.h:#define IntrRxTrigger        0x100   /* rx data count reach tigger value */
kernel/trace/trace.c:    * to store the trace event for the tigger to use. It's recusive
tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc:echo "Test histogram basic tigger"
tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc:echo "Test stacktrace tigger"
tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc:echo "Test histogram trace_marker tigger"
tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc:echo "Test snapshot trace_marker tigger"



