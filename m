Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCB3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D572073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTt0rStr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgEFMyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:54:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42383 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728081AbgEFMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588769674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLYsbiMJHe5P04qPfUk3182VS/dhNwaPh97sPV/RoeE=;
        b=XTt0rStrqdbSRRo4vFkjKyIZbcEWQ31GuFtL+SR5e9PkycxahpvNKiqub9KmXmKjl//64S
        66UkQr6VJ/YpUTqTQBHgVqatkkYFyHQmZ69myxx7P2sCc8KielMULathczdEzNbwY0FjRE
        zgxxhHDEMQ8ho7gcjk5y95DUzs1FnZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-1IP1S7pRMGCPFPFO13LZjQ-1; Wed, 06 May 2020 08:54:32 -0400
X-MC-Unique: 1IP1S7pRMGCPFPFO13LZjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C783A468;
        Wed,  6 May 2020 12:54:30 +0000 (UTC)
Received: from new-host-5 (unknown [10.40.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BA1C100EBA4;
        Wed,  6 May 2020 12:54:27 +0000 (UTC)
Message-ID: <5fd2df286f6d5bf813361cc8c907a155976a5c82.camel@redhat.com>
Subject: Re: [v4,iproute2-next 1/2] iproute2-next:tc:action: add a gate
 control action
From:   Davide Caratti <dcaratti@redhat.com>
To:     Po Liu <Po.Liu@nxp.com>, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     vinicius.gomes@intel.com, stephen@networkplumber.org,
        davem@davemloft.net, vlad@buslov.dev, claudiu.manoil@nxp.com,
        vladimir.oltean@nxp.com, alexandru.marginean@nxp.com
In-Reply-To: <20200506084020.18106-1-Po.Liu@nxp.com>
References: <20200503063251.10915-2-Po.Liu@nxp.com>
         <20200506084020.18106-1-Po.Liu@nxp.com>
Organization: red hat
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 06 May 2020 14:54:26 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 16:40 +0800, Po Liu wrote:
> Introduce a ingress frame gate control flow action.
[...]

hello Po Liu,

[...]

> +create_entry:
> +			e = create_gate_entry(gate_state, interval,
> +					      ipv, maxoctets);
> +			if (!e) {
> +				fprintf(stderr, "gate: not enough memory\n");
> +				free_entries(&gate_entries);
> +				return -1;
> +			}
> +
> +			list_add_tail(&e->list, &gate_entries);
> +			entry_num++;
> +
> +		} else if (matches(*argv, "reclassify") == 0 ||
> +			   matches(*argv, "drop") == 0 ||
> +			   matches(*argv, "shot") == 0 ||
> +			   matches(*argv, "continue") == 0 ||
> +			   matches(*argv, "pass") == 0 ||
> +			   matches(*argv, "ok") == 0 ||
> +			   matches(*argv, "pipe") == 0 ||
> +			   matches(*argv, "goto") == 0) {
> +			if (parse_action_control(&argc, &argv,
> +						 &parm.action, false)) {
> +				free_entries(&gate_entries);
> +				return -1;
> +			}
> +		} else if (matches(*argv, "help") == 0) {
> +			usage();
> +		} else {
> +			break;
> +		}
> +
> +		argc--;
> +		argv++;
> +	}
> +
> +	parse_action_control_dflt(&argc, &argv, &parm.action,
> +				  false, TC_ACT_PIPE);

it seems that the control action is parsed twice, and the first time it
does not allow "jump" and "trap". Is that intentional? IOW, are there some
"act_gate" configurations that don't allow jump or trap?

I don't see anything similar in kernel act_gate.c, where tcf_gate_act()
can return TC_ACT_SHOT or whatever is written in parm.action. That's why
I'm asking, if these two control actions are forbidden you should let the
kernel return -EINVAL with a proper extack in tcf_gate_init(). Can you
please clarify?

thank you in advance!
-- 
davide


